Return-Path: <stable+bounces-233269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCVhIpjH0GkMAAcAu9opvQ
	(envelope-from <stable+bounces-233269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:11:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F7339A56F
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55718300E17D
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585A53A4525;
	Sat,  4 Apr 2026 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUF11hGY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA023A5421
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290259; cv=none; b=AHZhTDnLgZwWd+qbMASbtg6ILPGXQ8oxGiqYTYZOpqJk9v9KSfcvhx6IiiQ9DABjfnx+AVrVPoLoWqDpCT8wIs0RJ5JB/11xkZ9OzAvyFpf17RPvYA93hWguJXpSm1GSqIC1vhwC7IJUey1rwR6dbKH3/1nipOmGAQ7UzTONaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290259; c=relaxed/simple;
	bh=/qXGPqxuZuzFUKXFwMaKnp17rwob3oDV39p/bkWtKoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4nyhTZ2nOFo5JaLkhizhBv+NCqoOLO10c1Tja+S6Y6VBiFnjGyhDrwTzCW4sLJwW7cz7x1c76Nj3k+pQGzG9G6zAi+0bDattWu9xZQ6Lkv73/nIznGn3NifFeOmBTVKxKBY/VmdjLRpb3yKhcDiAR0wSeyYvCOh75+rLEN1jzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUF11hGY; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso1583500f8f.1
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 01:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775290255; x=1775895055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ULP8DbOuEXZhN3CexgIC4rE4TGyJM/8Cix5w8Cv44c=;
        b=gUF11hGYp0C5b47aquOO7Gh085MWx/FAPU+UARJu7rJQnGeZ3mJcl0+0GNJLV6K5xe
         jR8XoBGP7RnBVaYagihlGoehi1qdgCKWacD4k2mqrFsmLXE6GWz8iVeUvIS5p2MebJxD
         weIBq6nyIi+/R/HdyExxbanOy+ml8DfABtUg3buXAUZ8Rl7NyaH3nQy10ZNLbH/IRajI
         WcF+4/xiipeTGCNVRuFoiLNx4JHmFSHPeWqk1xgH0QbqJjgFaKQidqLjPtg1e3gIO/A3
         T/8mhO17KzWHIQncYMwUQDSIZFYXwLDRJsnt4IozgrCMjRE06zQPWt8MKYBPY1/pQFLu
         74/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290255; x=1775895055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ULP8DbOuEXZhN3CexgIC4rE4TGyJM/8Cix5w8Cv44c=;
        b=mppEc5XspLVJIvOUtgYe4BjfbooRdsopbGsnXgaobZKzpGCQOwh37ALLzSTQsl0uyo
         Twx3EZRvMU5TMYt8hhftk/S0Hr0Gu3hnW9PLvq92PDFxHHd9cai6K9oK/8Uh+Li0WtZs
         K7TPxjg7nqqmSXcEM26IZatxKNl/btO3/qU92u4jNPNczw7EJmdQ7nBhv888NdbTV/cE
         6IWpyPXXlbe6dlUvXlGRvHTSqVYOp+65mcWP44pbztmytsCyJ6GRuv7zE1fVc2NiyGiH
         vNjXpYOS3E0H+86nFV/FJBPFmAyggiUDmK76cAK6H6Xir21pQzHu85Lf9uTdk4bIQDNY
         AEiQ==
X-Gm-Message-State: AOJu0Ywkmqr+oijq5wS1QAbRUyqlacr7V8gMx9LzQtC4jltqZsEVYuI4
	LfANq/N//rslUv6scgUz9RC32DpNJ9wIPqscItrtDe0kBLceXtuVU8icjykUi/Z5
X-Gm-Gg: AeBDies9PHaRNJH+CmEfqrEDMv5ZzAjWhQ+9Yg2fkjCtxwXR4OX8kq5KzpfQBpw426b
	F/KqkWoSLUW0r1boUbzFyt8Wrn2MY8CVIVGzTnKLFqtYDjY8YW4jpqQGpo1EXJRM53LdlGGXDqO
	WJz4P+YHx/5E9OOUpsB7HKnM+fNKU7BcyYxBfh5MQ51pI9Gb3zYdnln1i8b+w2bbrEHFyRXrRf4
	/6nE4wNTvs4vk9gM6/ijTp35AK/mLP4H3gLSPe2Yn+XojwVoJOEXOt9fKuCMBvxsfRSmlxpy6R0
	HyZJr6UlmbeIJr/KbBAJ/xZioMO8iquOCsldzgvLlbw6XsHNf/RUlglOctazZFnQ19xB7UHELoA
	bO3Cz7WTGwWnptMgCI0+3+02hOOtZajaZFDY2SmnF60ZVKw45NO7lUhbIIRlyVYAhlb+b+jQkOn
	0ZANxdBvTdOrkRT/VZQppRpWJy0A65ZkFq6RAMDtiQYnTaLZqGtkX1eTGcPoGJa2LMJJkhbm9Y0
	wXpfkX+RJQlwmWf7+Uydoyly/jRTvLSB2K4Ux3+0LGLzclwpkk0wR0u50sR0D42+taFEyzD68Xz
	c2jo1USS1ZFB3tA6x3Zu98woiYu+kEXVDRkDcZltakY=
X-Received: by 2002:a05:6000:1a8d:b0:43d:4c:22ad with SMTP id ffacd0b85a97d-43d29300b0dmr8284436f8f.42.1775290254920;
        Sat, 04 Apr 2026 01:10:54 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00359acd79a267583c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:359a:cd79:a267:583c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c60a2sm21726134f8f.10.2026.04.04.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:10:54 -0700 (PDT)
Date: Sat, 4 Apr 2026 10:10:52 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 1/6] bpf: Improve bounds when s64 crosses sign
 boundary
Message-ID: <0f6da4f74ebc491dd651dfcf3ba984bbd3dc566f.1775289842.git.paul.chaignon@gmail.com>
References: <cover.1775289842.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775289842.git.paul.chaignon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233269-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02F7339A56F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 00bf8d0c6c9be0c481fc45a3f7d87c7f8812f229 ]

__reg64_deduce_bounds currently improves the s64 range using the u64
range and vice versa, but only if it doesn't cross the sign boundary.

This patch improves __reg64_deduce_bounds to cover the case where the
s64 range crosses the sign boundary but overlaps with the u64 range on
only one end. In that case, we can improve both ranges. Consider the
following example, with the s64 range crossing the sign boundary:

    0                                                   U64_MAX
    |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
    |----------------------------|----------------------------|
    |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
    0                     S64_MAX S64_MIN                    -1

The u64 range overlaps only with positive portion of the s64 range. We
can thus derive the following new s64 and u64 ranges.

    0                                                   U64_MAX
    |  [xxxxxx u64 range xxxxx]                               |
    |----------------------------|----------------------------|
    |  [xxxxxx s64 range xxxxx]                               |
    0                     S64_MAX S64_MIN                    -1

The same logic can probably apply to the s32/u32 ranges, but this patch
doesn't implement that change.

In addition to the selftests, the __reg64_deduce_bounds change was
also tested with Agni, the formal verification tool for the range
analysis [1].

Link: https://github.com/bpfverif/agni [1]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/933bd9ce1f36ded5559f92fdc09e5dbc823fa245.1753695655.git.paul.chaignon@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68fa30852051..6448f9eeede0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2129,6 +2129,58 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
 	if ((u64)reg->smin_value <= (u64)reg->smax_value) {
 		reg->umin_value = max_t(u64, reg->smin_value, reg->umin_value);
 		reg->umax_value = min_t(u64, reg->smax_value, reg->umax_value);
+	} else {
+		/* If the s64 range crosses the sign boundary, then it's split
+		 * between the beginning and end of the U64 domain. In that
+		 * case, we can derive new bounds if the u64 range overlaps
+		 * with only one end of the s64 range.
+		 *
+		 * In the following example, the u64 range overlaps only with
+		 * positive portion of the s64 range.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
+		 * |----------------------------|----------------------------|
+		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * We can thus derive the following new s64 and u64 ranges.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxx u64 range xxxxx]                               |
+		 * |----------------------------|----------------------------|
+		 * |  [xxxxxx s64 range xxxxx]                               |
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * If they overlap in two places, we can't derive anything
+		 * because reg_state can't represent two ranges per numeric
+		 * domain.
+		 *
+		 * 0                                                   U64_MAX
+		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
+		 * |----------------------------|----------------------------|
+		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
+		 * 0                     S64_MAX S64_MIN                    -1
+		 *
+		 * The first condition below corresponds to the first diagram
+		 * above.
+		 */
+		if (reg->umax_value < (u64)reg->smin_value) {
+			reg->smin_value = (s64)reg->umin_value;
+			reg->umax_value = min_t(u64, reg->umax_value, reg->smax_value);
+		} else if ((u64)reg->smax_value < reg->umin_value) {
+			/* This second condition considers the case where the u64 range
+			 * overlaps with the negative portion of the s64 range:
+			 *
+			 * 0                                                   U64_MAX
+			 * |              [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]  |
+			 * |----------------------------|----------------------------|
+			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s64 range |
+			 * 0                     S64_MAX S64_MIN                    -1
+			 */
+			reg->smax_value = (s64)reg->umax_value;
+			reg->umin_value = max_t(u64, reg->umin_value, reg->smin_value);
+		}
 	}
 }
 
-- 
2.43.0


