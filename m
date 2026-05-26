Return-Path: <stable+bounces-254391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBw8NibMFWqQbgcAu9opvQ
	(envelope-from <stable+bounces-254391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:36:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AED5D9CDD
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6942F30B6F3E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8C3AEF46;
	Tue, 26 May 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqgC/fMR"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E93AEF3B
	for <stable@vger.kernel.org>; Tue, 26 May 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811805; cv=none; b=FDiLQshehahSJKPf9eXmz6ZyudKUdqT57ilGO6CMsgBO+LySSXnhvBZy6bmNF39Rjt61SQs7Dj3ctzKjAsbBPc/B7Un5fECtkeOuvQ1J8VhXkT4SxvlW3cxzhpn4sAzh6bzXV1JL2TpeN79GIdZGhFTRo1droAvUj3rhPQ69UxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811805; c=relaxed/simple;
	bh=CtU3eZ1/9ucFeiYFj1sbRvl27Q7jFnsviC59r78Kot0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsFbJuHYr/iN9clfr4/drmFqmoPqCwyTCZaynrpmQtbAffrCTVi3uq3pvONmNIdGVXgFyhjqtHot7DJbYYlMeNRH4z6nM5KP/3WT12WYZcJFPH5GkaaJOB6MRiGEP0+AxVVu4+r73e5rGoOKlpH0d21CvAXhIj9DOx60rqymNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqgC/fMR; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-57746f02da7so7128200e0c.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779811803; x=1780416603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ar+gEVufB/yu7goDjk5NwqRP0XutqMUX6lN4uW/AcuU=;
        b=VqgC/fMR+Wl9RYZNsSHL58z/xeCtKMJY+vKMV8wn6KudG2u0gxcoQ6w/iBdu8QT/az
         5sWLs5nCRaIyHCL3zZZESqbgT9PfDhd3tNgZJSw2FIgvguZTq7yZx7hCzeXkioy2vDwL
         /qb2sWrDA87XOiTeWPgtKqFr4cdMYL/YRPmM2wJ8X6lfoYXvHx32uDtWIsxqt7rJX9nq
         N0oy2zzwFjiyMqn8RSe4DIjNQpOHzTKjP4hoxZPUcTS2VFlCLSGMyQEMcP0aQ7shBybD
         yXGa+L+kj47UwhZH6OJQ/YtEvTGGPfk066paD4pdLYDcrUgdao7NWz1gclWzRTyUpLfb
         3sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779811803; x=1780416603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ar+gEVufB/yu7goDjk5NwqRP0XutqMUX6lN4uW/AcuU=;
        b=eiDTWizE02v6oQ6UB9Xa/LH+NysYnlNkkE1PO6ukIQNby40CT3T7eO1i7C1G3G7I92
         6yPNlMXqskSru7IidmDSiMFktv4mlzhwRCvBPP/i58lu17AlCoXFX/CKuPDoVy1jtT0V
         8efxfwEbSO9p6glx8LoNaFh2aW2/BgkA8QP33Btaj0IyIzDx/BB/dh7h0zjaRY0lT6Il
         zv9YDG6bHkw13zMdoE8FiGHgSUa9RUO/bkbFTEynZCHzo+MISqFItn8YU8DrO2IHU3WF
         xSyiDD57FW2p05kh2oHbcDRTDJjyKK0maAxo0mglTberhGUw4VTD7hWvu9YRrfDB7/oZ
         iMFA==
X-Forwarded-Encrypted: i=1; AFNElJ+fhNrENVMlSrHSIioH9ZLnQpDSGvssx8PPjUJPg2HsYE6l9/nKZ2DsFGjILVG0y7ntu5vd/qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFb0dp2Tt/JJCtEsrHs7YuAm7s90WlaXEkoQFPgfLou9XUl+wK
	Za+761CjAMdfSQm5/YqP+FeGZAF8JkkLpYMvcCCuhLEK1AWCzc5OoTvr
X-Gm-Gg: Acq92OGCZtymz8ZpT5PfzaXCcOHsSiYS5BgLum7nFAEyLc7YHp1UbFtnr/4CJCFUedv
	Sx9It8tmme1toIcrZdtNjmNdxSRnwKWP2iHGQIpkzapDare+yAvL7GFKL6CSdmixzWprlsZX9ii
	8kYHwF0fPukshv8Z3Mu0UJc8nHAVg5Yt+Y6jPqg2bKt/QSTJR6ALPPv0JGY3l/U+pqldBFBIPoy
	7Rjrne78r4tHTDOHK6oWfeljztVdx+J9sJKqOcuNyKGZB80lC4gbzzWs6qiuZqGIzQxdJjwCLwm
	aqU0zDONLFJupEF8q8/OMrb3x/6DDWYDkW+KSohQ4P5fgh4aWOt+Yk5m3b5jp2cONw7OuuovjZO
	zOrO4VI1ZLL1FRTS5fRNURo3jknqnQPST0SbqsnOqsvWxgYz0H5UtID/sTK+tVaoq7hRTKhJPxi
	54p7SofBgK335kTz6IRSWcJWxG3eAem4f28uJyEcm1Z0DEVxuR+Zg22JdlJcDB0eKgidbQvQjWt
	MVg8amD0vfsGmX29R4oeKMxIyk5Bxw4HIFxb0HzA3JYsVVEFIt8TQ==
X-Received: by 2002:a05:6122:4d12:b0:56f:22ad:f5c9 with SMTP id 71dfb90a1353d-5865ee6c06bmr10259762e0c.2.1779811802895;
        Tue, 26 May 2026 09:10:02 -0700 (PDT)
Received: from sekiura-Standard-PC-i440FX-PIIX-1996.. ([186.122.244.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm16704173e0c.5.2026.05.26.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:10:02 -0700 (PDT)
From: Takao Sato <takaosato1997@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	w@1wt.eu,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	chopps@chopps.org,
	pfalcato@suse.de,
	stable@vger.kernel.org,
	Takao Sato <takaosato1997@gmail.com>
Subject: [PATCH net v5] xfrm: iptfs: preserve shared-frag marker in iptfs_consume_frags()
Date: Tue, 26 May 2026 13:09:57 -0300
Message-ID: <20260526160957.1497109-1-takaosato1997@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,1wt.eu,davemloft.net,gondor.apana.org.au,chopps.org,suse.de,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254391-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takaosato1997@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 45AED5D9CDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_consume_frags() transfers paged fragments from one socket buffer
to another but fails to propagate the SKBFL_SHARED_FRAG flag. This is
the same class of bug that was fixed in skb_try_coalesce() for
CVE-2026-46300: when fragments backed by read-only page-cache pages are
merged, the marker indicating their shared nature must be preserved so
that ESP can decide correctly whether in-place encryption is safe.

Apply the same two-line fix used in skb_try_coalesce() to
iptfs_consume_frags().

Fixes: b96ba312e21c ("xfrm: iptfs: share page fragments of inner packets")
Cc: stable@vger.kernel.org # 6.14+
Signed-off-by: Takao Sato <takaosato1997@gmail.com>
---
Changes since v4:
- Rebased onto the ipsec tree, as requested by Steffen Klassert. No
  functional changes; only the diff context was regenerated.

Changes since v3:
- Corrected Cc: stable tag from "# 6.8+" to "# 6.14+". IPTFS was
  introduced in v6.14, so earlier stable branches do not need this
  fix. Pointed out by Pedro Falcato.

Changes since v2:
- Removed security impact paragraph from commit message as requested
  by Steffen Klassert.

 net/xfrm/xfrm_iptfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 6c6bbc040517..62ba828632f1 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2168,6 +2168,8 @@ static void iptfs_consume_frags(struct sk_buff *to, struct sk_buff *from)
 	memcpy(&toi->frags[toi->nr_frags], fromi->frags,
 	       sizeof(fromi->frags[0]) * fromi->nr_frags);
 	toi->nr_frags += fromi->nr_frags;
+	if (fromi->nr_frags)
+		toi->flags |= fromi->flags & SKBFL_SHARED_FRAG;
 	fromi->nr_frags = 0;
 	from->data_len = 0;
 	from->len = 0;
-- 
2.43.0


