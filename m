Return-Path: <stable+bounces-229996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEmVAuaKwWlkTwQAu9opvQ
	(envelope-from <stable+bounces-229996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:48:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE702FB898
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED8D8301A9CD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423A73451CD;
	Mon, 23 Mar 2026 18:47:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 17.mo583.mail-out.ovh.net (17.mo583.mail-out.ovh.net [46.105.56.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA331F98B
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.56.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291656; cv=none; b=K3k7V9FXu3nRaMGd7NBGKJd/IxWNVLFczpuf/XuEFPeVJth631BsE5dSz2PL5G73Ul3lLK7TVvPD7ykeMr+rXq6zrb9wIEWoOBXMGZ/jYGkNUlvNXH0XnLOJdDbMbjb/ho3xQdQQMc8UfwSZD9/CTyG7PKLTGY5QszWwCuUuWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291656; c=relaxed/simple;
	bh=6oo78as35+YtdESEF9CD+Gy1Y3wzEQHQPTrFTJrl0qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kS2D4j2qlge2zZZdMslE5/J32sdKSCK4lZvK3Xfew0LMGNfQtt7yDAC9TM4IAg19922YtUuAGSOnjE7gVj7k7HG3cv6HkgGPuc5iGVLSyJjEKz2HPC0nvM3Q7FEwUarVJVVl5U69ESYUFk1QrZICbx6tIptaKfLN4wE+5U3OzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de; spf=pass smtp.mailfrom=schlaraffenlan.de; arc=none smtp.client-ip=46.105.56.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schlaraffenlan.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schlaraffenlan.de
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.231.204])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4ffhpk5zlRz5wgZ
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 18:41:50 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-bvwsq (unknown [10.110.101.71])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 03F33C0D9B;
	Mon, 23 Mar 2026 18:41:49 +0000 (UTC)
Received: from schlaraffenlan.de ([37.59.142.112])
	by ghost-submission-7d8d68f679-bvwsq with ESMTPSA
	id yaXWMm2JwWlpcgUAF2RYmg
	(envelope-from <kernel@schlaraffenlan.de>); Mon, 23 Mar 2026 18:41:49 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-112S006e6393550-6f78-4c11-b371-e1a762b7c9d4,
                    CF5F45155CC526890A7B96C462E82A48810857C8) smtp.auth=mail@schlaraffenlan.de
X-OVh-ClientIp:95.90.63.4
From: Jonas Rebmann <kernel@schlaraffenlan.de>
Date: Mon, 23 Mar 2026 19:41:42 +0100
Subject: [PATCH stable 6.6] libbpf: Fix -Wdiscarded-qualifiers under C23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260323-linux-6-6-y-c23-v1-1-a62654ec6cff@schlaraffenlan.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFrxJm3RQzgbT0KqULjROdImnJaLGId
 3dU/urxeW8BocIk8DALFPqx8CcruIuB2Ne5I8utMmCFofLo7cB5mm3Q/W1URp9S6/Hu4s2BWt9
 Cieej+AQZ62YgE64BXucnU/OmOO5JWNcN0XMrfX8AAAA=
X-Change-ID: 20260323-linux-6-6-y-c23-23ffd3281c71
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
 Florian Weimer <fweimer@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonas Rebmann <kernel@schlaraffenlan.de>
X-Mailer: b4 0.15-dev-bc6c4
x-ovh-tracer-id: 9902852630984688504
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEn/J6J/8oJOu163+irf06IZR7B0eNHOlYDG+K3cMLQXahaG623YFWOqt7Op7yBD+rA3+M2zSREOC2RnMk5cfEKkFJtJ7AcsmM4Bmw+bLaS6DPKw0eI/obDpmxw4xMUl0NziH+lM2DYqgML9JxKDX04MKamhHVg9vCzSVhNsgOUQvWJkQF3jqW1xmYsNOM4MuDsA2LZw470JvwQmzeChC1tsNdHnFGYQF5vR1xcq/vQiAdUhYsKTtLqfoNGJDAYOvwUrYpoR1oRgohmx3+R2agj+KJsJh7T1uL3O7mi6HZYV8UJfdcHaMKsIeM6fhpSv/zzOSgghFMeWQpv05im53jZka1R5PeXrgZbtqCJTCvxNYyYRnUyeuFCMbXLSVhu/IF/odQUHuTbTK/0bHtgNpm8y+OERB96miplMreUX4y/pxVsnRapxPu51d1U+P6KJiGO4d5nkTd0vA5t15ER9CZ/tI0q4/anBz+LSvGzTETJnRTv5iicVeYg/La4z+bLwt8lllXuPXDv3NWk42FJYZ/1x/iisVOoFzYcgMuJLKkwTVMCGM/2qGWhWVtl2RYrL9frnmlk7VMJIEB5qh3LOLIJ67gWPyyL4oJeJFKbjx6OftrHWHLE2SoRcejtyL5Jd3EiB+nBKvShVJEJQq7APzrgi1SerMtm27JBxAceqJXgRA
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,redhat.com,kernel.org,linuxfoundation.org,schlaraffenlan.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229996-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DMARC_NA(0.00)[schlaraffenlan.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kernel@schlaraffenlan.de,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,suse.com:email,schlaraffenlan.de:email,schlaraffenlan.de:mid]
X-Rspamd-Queue-Id: AAE702FB898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

commit d70f79fef65810faf64dbae1f3a1b5623cdb2345 upstream.

glibc ≥ 2.42 (GCC 15) defaults to -std=gnu23, which promotes
-Wdiscarded-qualifiers to an error.

In C23, strstr() and strchr() return "const char *".

Change variable types to const char * where the pointers are never
modified (res, sym_sfx, next_path).

[ shung-hsi.yu: needed to fix kernel build failure due to libbpf since glibc
  2.43+ (which adds 'const' qualifier to strstr) ]
[ Jonas Rebmann: down to one declaration on 6.6 to resolve build error
  with glibc 2.43 ]

Suggested-by: Florian Weimer <fweimer@redhat.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/r/20251206092825.1471385-1-mikhail.v.gavrilov@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jonas Rebmann <kernel@schlaraffenlan.de>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 95f2ffefff3f..802ae6dbddfa 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11247,7 +11247,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')

---
base-commit: 4fc00fe35d46b4fc8dac2eb543a0e3d44bb15f47
change-id: 20260323-linux-6-6-y-c23-23ffd3281c71

Best regards,
--  
Jonas Rebmann <kernel@schlaraffenlan.de>


