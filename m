Return-Path: <stable+bounces-245136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF4LM2yJAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:46:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCD5097D8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F5C33086F71
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53038F64E;
	Mon, 11 May 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr+N0BWN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDE386571
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485037; cv=none; b=bCxffB8PTBRVN/SK12QKnGm7jgfzLFC1tDh65IvszcjR0t+bwXhjh9ok9ZzeuB91uryXCp1PdRdq1jPCYWLktPYYuMwrXuQOKkUnXVrIsuyOYveAVVEgJKCKPneCrOg4uVzdHfuVEovohaJipcN26z8q/VnD4BX6pu/AR7ghnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485037; c=relaxed/simple;
	bh=dALL0V8+izpqRciW84d8NZM4vsK/GMTEIm2uBsS0Duw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv5iT+eIU9cTUE9d+uyXIjAPcn77XQD/rsvZupoVxLlaOp8nel7WLXmBL0fw1ATnUF0Qr4oR/YMAvfy29tRQ4UrRwKMkm2bZe8nPH5ljRD7trBtSAI9otHfnx20SZl+JtTnEgvEEoD7ztqRINBojsw58qsBoasZpys5+2vNQVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr+N0BWN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d933da14f0so453953085a.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485033; x=1779089833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxGtnytbDRgBJh7FP76pZcQknmYMFeXzaElRkErNL/0=;
        b=Lr+N0BWN89vOpEqcPGz3KUDu1flfpFWw4k+CnV/PXcBwpE08lmP4XdBBCbHrj1hrfi
         SHS1Okys1ZfXbGKjn4X1WQFNP02chXIOhSBpr8NxwqkruwQGjlv/HqPAjju2TmmutHam
         EDc5OdycEFTQBw3HDxzzxDm7ccZyVyLVvsyu0u4wtauuTv2tgUewFlGrO/8t8s+C2O1x
         022I4aSgh3z/P9zMhTOWMDgL4BuK7/fC2l+/nHd9yM2+IDBFCRBLI9odnbq8rJNrovQ/
         8/mSumXJOz1Zwf9UOfTgJQ2/rBnIve70Y4aYWGm4DdxSWgJ8s4ir8Z+nhTK6gTZhpoYL
         GGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485033; x=1779089833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxGtnytbDRgBJh7FP76pZcQknmYMFeXzaElRkErNL/0=;
        b=Ed88q9ri++TkJDZBHrK12z7xNPniXPRsJ6yhmSu+JCxC4VbwSRgMzNwkWhvrR2pS2z
         Fvk0DFKaJLsvv2xTVco5KJghNyHgBkuPCmXeShK6ItXV4atVs5sni+tVz+bo5bVGcFvZ
         m2F1Y3EkPaOh7rNYvbRwZbaoWTj0LkaZUJmVAzX10pqPiw0lyZB7+T4vHFGWWGBE1QMP
         9ObfNXdo/fMvzbeF3Rytc55D6oac2HpjCi1nNK5EAhOIY8GGUxDSOnD4bjhs8T46T9yz
         igWSoZB16F4bnOOE7GRmVKMlzpJ01KuQfCf8nbqC/VX4khWl+Yy0yJvndAE15wIS4STo
         n7ag==
X-Forwarded-Encrypted: i=1; AFNElJ8UKpBMAvIRLioIpHivgY/bilQ7FYbSQPPFN0QkIw8QyEwA+A1GC28YDL/YbQhh8ycrDG8EDX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBd3TAMeobFlroAHxz4n2IYLVIx2IN1D2bXdWFBTooGGq5gI6
	mcgrsVECyKGy2tllAEDZBKUO4xdrxURFJyhDN/utKcbggVH93vsSZojs
X-Gm-Gg: Acq92OEsEGQrk4VOGRInd1qxPz1WVtQI7QPn4lXY1SVXj7RdnzpKrxBt+Wdttfg3Ck+
	Dx3gr3qBGERmbySjFy3Mle6wDtinNlnEnNh1oZU0e5HlrRverqApoQv9N/CmGzilJ+z/joYayCz
	f4kQNAzZ/VNy3kkca9uhsXFBc2DbjIxmu3V5byFTa7JVGWDeP6JvUPxgz9KZBau9YddHcTOi2gY
	Hu8EKNvgZISm+QWPHinpyt9OR15XzWxFaAkHaKGlww7HvIVBVwMMyk9iAcAbrM4hgPENRiDxL6Z
	DD9tRkG7YGUzbsxFfmSz++E1YsWPHalMEJtHmu26IHnKh0xeGL0AYq4ZMLJzoBIK1uRctze+984
	OxReolxREnsBsYNo8ald4W2zK5zr4tcGz30mb0llqVIJwt5KBAN0cP9NAyIixI2BpwWnyJ587F4
	O52my3nJt2pM7+xx0ldOBYbf80XWLu4h85U41s4UnVXlOVSpOgLPnfYwjYsoPpCJNgo4l+i2af
X-Received: by 2002:a05:620a:4707:b0:8cd:9599:b7c7 with SMTP id af79cd13be357-9090ecbdf77mr1258840485a.23.1778485032723;
        Mon, 11 May 2026 00:37:12 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:12 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y v2 14/18] perf bpf: Fix -Wdiscarded-qualifiers under C23
Date: Mon, 11 May 2026 12:40:47 +0530
Message-ID: <20260511071051.537859-15-yesshedi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511071051.537859-1-yesshedi@gmail.com>
References: <20260511071051.537859-1-yesshedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1ABCD5097D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245136-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.965];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

glibc >= 2.42 defaults to -std=gnu23, which promotes
    -Wdiscarded-qualifiers to an error.

util/bpf-loader.c: In function 'config_bpf_program':
util/bpf-loader.c:588:27: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]                                                                                                            588 |                 char *s = strchr(main_str, ':');

Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index f4adeccdbbcb..7f4e774a3435 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -585,7 +585,7 @@ config_bpf_program(struct bpf_program *prog)
 		goto errout;
 
 	if (is_tp) {
-		char *s = strchr(main_str, ':');
+		const char *s = strchr(main_str, ':');
 
 		priv->is_tp = true;
 		priv->sys_name = strndup(main_str, s - main_str);
-- 
2.54.0


