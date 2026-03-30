Return-Path: <stable+bounces-231016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LnFMhkeymmu5QUAu9opvQ
	(envelope-from <stable+bounces-231016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:54:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 339263561BA
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49B57300DA5B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E039A070;
	Mon, 30 Mar 2026 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLGBj4te"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0B39A809
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853639; cv=none; b=ZjmA4qAqejAGLPFVJ7hJnOVTv2uZ962g16fqEamXg/GqJ/tHCAWXscaehDnn7EgKouQbQ9FNKfhZuAGWWrlACkrHw/PJzg1rXMPRuvioZkJXkV9bcPdHfT5+3I9JxB+umaLjFEnTQ372aBiwE2pqnVcBfPOtaHStfG81bJPfP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853639; c=relaxed/simple;
	bh=1ZMQRFTsE9RGEd8MISqxE82qOuGiFFOcLA43cHDuWsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dnd+YtzFzWMYGQzA/GfBE2FsckViwjH64X+QJEpJ3sqbzwmIRb2B2UyG+vCuq1qF1BlbRG5fs3BZ4I6dJLrfMwfz/RyD/oRR4cdhS0HFq/FTT5a50lTwe8N32bAU4rzrxE0WiTUOFxC56KRVgj1ygP9HCOcNwvWmKCp7fiLLd9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLGBj4te; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c2239140aso1642380b3a.0
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774853636; x=1775458436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Sfp0Ek0ayKazM5uQym569fBFMivhcwWZXFfdYQ8Y8=;
        b=TLGBj4teOMRDIwTEWJ8OAm94rPixaY0l6q332vqr9JcKxF/M0kgTFD8x4gYm7FHK85
         hLEF9sYUD84Et9LScnn/WciRvZJYfvW0SdseIUC+NFxzYsCZzwotrV6Xjx6TgEwfA7Dt
         zE0Uuwg8JbBHXbpRdy+0Igb9HAlVQ7Z+ngWru+5AeD9fEt+RUW/0z9xftENH2Y/L0HXf
         UEr0yWxci+D3XEjYGRvtZlGcJgSz0N3Vm78Ak8xZgNQixQxhjm9arWKWdB5RQJ2BIzW2
         UqcbHFYBK4H0Kk9kzLvBFhmdolch1KWKRDO9UYwCeyDzF+k+ZUtebI9BzPkXs4tOUgaj
         ArDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774853636; x=1775458436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N3Sfp0Ek0ayKazM5uQym569fBFMivhcwWZXFfdYQ8Y8=;
        b=BVkaw/cbg9t2u2Ybm15kEZ5KiSmA/3c7aLXXQsKJL/o6yHkq3iQnP+IRZp4tBSRah/
         u4YjzU/DB7d5O+g3fqqS9ElWXspQAKiv2E/IjjZan05gOrKH1XmpFGoBoext3B18d1Ey
         lMPPBsaPdbjjaL7HszqMaaE18F24oOBYV5UUvdaQgJIlFpBe212wQKpJ/G+hf3zBE8Tj
         oHm/+g63pM08pjTecvLAudXgAPojLzRtacg5bvTU8FuzvAb0Tf6nkoKarOkvol888b+0
         qljy+CaKTWQ7FPBiynRvPNLzsSrywouCCTKweuAr11Bz9xmc1BGqSwO6Rfe0YOQkr/mj
         sYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2gTOkV8oPGP63obbSsVIfkV+l6Ztcz4IheUMZ3+SDd3Myy8fInptbOh14V8ZGzwOoTNojSyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3iRdzqdOdfZSaoQh9sYAw5xObNOAXJWuqfFdgy12s3cRyB3G
	de7NddNyH9jFez/xbBjKNkmrYu1X9/ADXwfVMGw0YIEhyCa+41ujypHe
X-Gm-Gg: ATEYQzyHAu6VXjte7rw4LF0pbzd4M9RC/pN6sN/QnHmJRfv9bzvv5LecadBrRIfl1Mm
	wX7htbkBbWNi0aMgxPKKQJWGEfso3OSgF1Xb1pVPEWOfhbOP+Qy9UUVMgML9EEKdjidv6GlkCt4
	lz7guQBpsZ5hTxZDoITOyZ1Uz916y/a12QClJIsCsI+9E0p9h1ZbLYdn46q2h63qD0Uevxt7Rca
	UnEfh6FK6V1+r3R7dKjDe9VEGZFIfnuwnCg3U+CmYRTxTwr90W0o7GLt8h3FUICdm0R84/S8af+
	ywJvO621eon44lDjvbEZBMc2m0xDyyKuPysMvde7+5vQwTX//OUqiZ8X60rkx+JJxeqZpmYoB8C
	KFz/z05xeTujQVOpmXc7BHoiKFKstNQJf9XOjmkXqL3neIMvXW/cQAZCnwTSpnTlp/uKad2/0wX
	P//gh9G6lH9TcXwN2DVzSZg7NW+his
X-Received: by 2002:a05:6a00:4511:b0:82a:110b:e212 with SMTP id d2e1a72fcca58-82c95706cc7mr10873894b3a.0.1774853636040;
        Sun, 29 Mar 2026 23:53:56 -0700 (PDT)
Received: from kfuzz ([202.120.234.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8466e01sm6287090b3a.20.2026.03.29.23.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 23:53:55 -0700 (PDT)
From: Kangzheng Gu <xiaoguai0992@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kees@kernel.org,
	thorsten.blum@linux.dev,
	arnd@arndb.de,
	sjur.brandeland@stericsson.com,
	xiaoguai0992@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
Date: Mon, 30 Mar 2026 06:53:42 +0000
Message-ID: <20260330065342.145549-1-xiaoguai0992@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329190350.19065-1-xiaoguai0992@gmail.com>
References: <20260329190350.19065-1-xiaoguai0992@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-231016-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.dev,arndb.de,stericsson.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 339263561BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cfctrl_link_setup() copies the RFM volume name from a received control
packet into linkparam.u.rfm.volume until a '\0' is found. A malformed
packet can omit the terminator and make the copy run past the 20-byte
stack buffer.

Stop copying once the buffer is full and mark the frame as failed by
setting CFCTRL_ERR_BIT so the link setup is rejected.

Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
Cc: stable@vger.kernel.org
Signed-off-by: Kangzheng Gu <xiaoguai0992@gmail.com>
---
 v4:
 - remove the Reported-by.
 - print a warn message and reject link setup by setting CFCTRL_ERR_BIT.
 - using %zu to adapt the compilation of 32-bit kernel.

 net/caif/cfctrl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index c6cc2bfed65d..373ab1dc67a7 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -416,8 +416,16 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
 		cp = (u8 *) linkparam.u.rfm.volume;
 		for (tmp = cfpkt_extr_head_u8(pkt);
 		     cfpkt_more(pkt) && tmp != '\0';
-		     tmp = cfpkt_extr_head_u8(pkt))
+		     tmp = cfpkt_extr_head_u8(pkt)) {
+			if (cp >= (u8 *)linkparam.u.rfm.volume +
+			    sizeof(linkparam.u.rfm.volume) - 1) {
+				pr_warn("Request reject, volume name length exceeds %zu\n",
+					sizeof(linkparam.u.rfm.volume));
+				cmdrsp |= CFCTRL_ERR_BIT;
+				break;
+			}
 			*cp++ = tmp;
+		}
 		*cp = '\0';
 
 		if (CFCTRL_ERR_BIT & cmdrsp)
-- 
2.50.1


