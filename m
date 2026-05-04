Return-Path: <stable+bounces-243388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ALMLh+r+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8D14BF1C6
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 871FC300BD57
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8B3D3334;
	Mon,  4 May 2026 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FrBpOex+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F711ADC83;
	Mon,  4 May 2026 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903755; cv=none; b=NLcXqyRTbTWEkiWRf+MHXyVIQc13+5TNPX1zEH77UxJyVqa7B3Hm3gCQnMJz0jy7qcfm6/UxBnwVTysaeV65NYlLM6Mn+ACE9eyNAkGrMADHfsH3y23m3e9Jpd8palfqtnaqQCYXncBKYRHvC7JlIR4carLow40J5TYivXewvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903755; c=relaxed/simple;
	bh=zZg0iAf4Xe56S6A0ttXnkZGnCyeRiqoJsJ1N0E+tqvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsTd8KR3s+iDLu4pN1s38Y7I/XWZu+ENdfrOjTJ0VSFMdBGxJoG4X51RLZqlaU1pNi1NmwU75fU6waKWzN88wSrC49wRGpKNE6bfNPxlJaBuNI8Wum9jrcn+2qjTZgEOGJWEoHxyszWk/+1m98Tz1KS9mzYRPuHhO5DhtQ2/IHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FrBpOex+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD89C2BCB8;
	Mon,  4 May 2026 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903755;
	bh=zZg0iAf4Xe56S6A0ttXnkZGnCyeRiqoJsJ1N0E+tqvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrBpOex+YFTV60Stw1d2tV8UOsfYnH8PkAYbYou84Lb+7s0u2iioPKJzyWs/VB7ge
	 s3EB6brTJtl5pTfx1+rPOcgnoCM0ZcpXqyr72lHRD1xmYmJV8G53mbHvnGpjFT4qaN
	 I0pXBck5IpNK0NvICSCnle00BTrOtjN+FHbFxoYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziqing Chen <chenziqing@xiaomi.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 048/275] ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
Date: Mon,  4 May 2026 15:49:48 +0200
Message-ID: <20260504135144.723152413@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC8D14BF1C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243388-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xiaomi.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziqing Chen <chenziqing@xiaomi.com>

commit e0da8a8cac74f4b9f577979d131f0d2b88a84487 upstream.

snd_ctl_elem_init_enum_names() advances pointer p through the names
buffer while decrementing buf_len. If buf_len reaches zero but items
remain, the next iteration calls strnlen(p, 0).

While strnlen(p, 0) returns 0 and would hit the existing name_len == 0
error path, CONFIG_FORTIFY_SOURCE's fortified strnlen() first checks
maxlen against __builtin_dynamic_object_size(). When Clang loses track
of p's object size inside the loop, this triggers a BRK exception panic
before the return value is examined.

Add a buf_len == 0 guard at the loop entry to prevent calling fortified
strnlen() on an exhausted buffer.

Found by kernel fuzz testing through Xiaomi Smartphone.

Fixes: 8d448162bda5 ("ALSA: control: add support for ENUMERATED user space controls")
Cc: stable@vger.kernel.org
Signed-off-by: Ziqing Chen <chenziqing@xiaomi.com>
Link: https://patch.msgid.link/20260414132437.261304-1-chenziqing@xiaomi.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/control.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1574,6 +1574,10 @@ static int snd_ctl_elem_init_enum_names(
 	/* check that there are enough valid names */
 	p = names;
 	for (i = 0; i < ue->info.value.enumerated.items; ++i) {
+		if (buf_len == 0) {
+			kvfree(names);
+			return -EINVAL;
+		}
 		name_len = strnlen(p, buf_len);
 		if (name_len == 0 || name_len >= 64 || name_len == buf_len) {
 			kvfree(names);



