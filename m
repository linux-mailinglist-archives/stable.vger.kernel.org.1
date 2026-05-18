Return-Path: <stable+bounces-249174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFWbM8aFCmpg2gQAu9opvQ
	(envelope-from <stable+bounces-249174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:21:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE95565636
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 05:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 358DD3009F0F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 03:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D537FF63;
	Mon, 18 May 2026 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcEMbVA9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AB37DE9D
	for <stable@vger.kernel.org>; Mon, 18 May 2026 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779074498; cv=none; b=Qy+FXShfcENeLNgEjoynLcOjwLwbCGAgadJgiQHX3Ct/HyO/ioqUoMJltUGmWH5x+jMxrHWXNSNZ9inBFv7UB5bmf/sDyDvuborTnCgIzq5DcdTwtTusDH7i0/vrW1apGpFLzPGWWHpm+FvFCmRl1tQhIANcE6cLcr8DhVsw1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779074498; c=relaxed/simple;
	bh=8bCQ/Iq0u1Lc/T7EX5SaevBnrMvazcgDznT+azAO2vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Axz3C3htwjb7KG/MygSdM9xsrOvLef4q4EyOMpMHA7LoUbuL2yEUBlX3wZGQNZzk3H/7jQj/m0AxLZj53aQTMEEArBdMkXm7iTUc2ZiG4ds7I+nw0O2zgA9PPC8k99AztEWhq9iGa5j58G4fO95YMWpUswE8eKNAgS5OGvWJzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcEMbVA9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bc6e4556d8so3902745ad.1
        for <stable@vger.kernel.org>; Sun, 17 May 2026 20:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779074497; x=1779679297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAFWkpA8YXLduhYX0RXRsoHuIKAwG9yvc6tBTptmV1U=;
        b=OcEMbVA9i5Ix8g8UOdkXYaZOmwDXtRS0zUElvzVEiVOA5iXzodmwlm2Du0J2rtXUSG
         s9whm08U5l6/63IGVll7mxhzjnC0gzmfGnrANzUzHe/68eK4c/nplABqbw5ibSuMpbsg
         /GhSpDkrllAyRBWQKBODQFjTu/zR87T9enS4HfpSSWuxn9w3wcGJ2eOPFgJSt+hOpLr3
         lxZ6iSacZ4d0CNg+DZHQdN2GWLk4h2gIRTJivFxV0eJOhLP+mhGzGbu/cWzYfYEHrLWR
         t2b4M7kgWjsUo7ic1tz5QDI2ggiW48hRNVk0CV5iXuvF6644xz/fS1itatnCydxRPjd+
         gtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779074497; x=1779679297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAFWkpA8YXLduhYX0RXRsoHuIKAwG9yvc6tBTptmV1U=;
        b=Rkl96nRnFk+XNQPiGsN5Vc92U1dUoW+4KlOUcH07ySl+EoOLeiNDMhZFR7CxGjiNcS
         FCdiAbradkngiSIBb+8Crznmbt9F1A1XopUuw4Ug1DN2tR7RW3nWGcvOmlamH05EGary
         Lj7hNefBgCWstudwNDdxhbQbmBBQ+KuXfs55nl9q+dJMc5JPHvACSvnVLMh8XlSAU8WE
         QYCVcX57ZtBu4w5JjqTOg0SdK4c/PypOmbh7yW3d6EyDoszJrHPN70MWNdDWSRzZyyxh
         BVGCZ6ECsIjPD0hZDXQJdXaf0ep6CI6d49JaaVDgfmEEGlZ+FYCjWE0Po0JAzMhpuLR5
         Ilzg==
X-Forwarded-Encrypted: i=1; AFNElJ87dVwVTVZuyoXu/rL/hdvm0tjxs54hS+aQtmJf0ZWrQRGNILsAyIIkBoDFRyeUMuE+wx/pIkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypyCaYjlZYh48HsLjtDnMFg4U1uMtz+VeUUS1iSUMj114xxlTO
	P4lTWfHqyxWJzwwPCWhHtRiapMvdyy5I/mj0Nkh2jiN+Wy8oJzv+mh0R
X-Gm-Gg: Acq92OHmBfjo9/QnWXgHFcvLuE2a3rUaZ6zc6FP0SS4mgKkLd6hDtJAfVrSlSjh8wSe
	U9vb7SH6pLAg7si/8AIgKMYU82Hs8mC4I5oUSszfBaYs991E3UeMiGouFYW2M4BBAdHsjqMYGhh
	0JK6tZ1HfjMVqC5KLqHWs3Fad5XrrpbW9LbfYEwMZB5CW8hBjPM72VErBKbnot/zjNa84NoG1ip
	4hUs2r7D/V7uc0Neph33jL3l+elASZ6PPdEsyYNqwx5rJl8d5fevs2y3Yju0PGR1sXuPQvR8fWp
	7IP6Uh0OwUOCfxhCvPehXgH6m22fgMaaLUBTqW0uCb8iLr8NWf60Gj5ugEdduYvsOtdrewWrg0I
	m8/0YnwOMdznwTgIMgSb7i2oIuJDsYZHxw/mXvllMueJiqKOGkpDCPRWAHZScT3IAaPDc6yp182
	LkzLxIkaVDUOR1Ak2au2wdNnlHvM0UICcvTLPXsot+mhyOCTKXnRgv139tZS/MSsI6+gTSB6GJC
	HJrT++KITZPDRMxZVjGxLORHpGCLvPCHg==
X-Received: by 2002:a17:903:3c4b:b0:2bd:612b:9124 with SMTP id d9443c01a7336-2bd7e23f084mr76532925ad.0.1779074496732;
        Sun, 17 May 2026 20:21:36 -0700 (PDT)
Received: from localhost ([240d:f:a5c:fb00:b9d0:5976:9793:153b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6b8fsm136391305ad.46.2026.05.17.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 20:21:36 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	"David S . Miller" <davem@davemloft.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Aaron Esau <aaron1esau@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfrm: espintcp: fix sg.size corruption on partial send error
Date: Mon, 18 May 2026 12:21:09 +0900
Message-ID: <20260518032109.616327-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4CE95565636
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249174-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

espintcp_sendskmsg_locked() calls put_page() and sk_mem_uncharge() for
each scatterlist element it successfully sends, but never decrements
sg.size. If tcp_sendmsg_locked() then fails partway through, the error
path advances sg.start past the freed elements while sg.size still
accounts for them. A subsequent sk_msg_free() in espintcp_close() loops
until sg.size reaches zero, overshoots sg.end, hits zeroed entries with
NULL pages, and crashes in put_page().

Fix this by decrementing sg.size as each element is freed. Also use
sk_msg_iter_var_next() instead of raw addition for sg.start, so it
wraps at NR_MSG_FRAG_IDS.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 net/xfrm/espintcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index e1b11ab59..6755f6df6 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -237,7 +237,8 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 		ret = tcp_sendmsg_locked(sk, &msghdr, size);
 		if (ret < 0) {
 			emsg->offset = offset - sg->offset;
-			skmsg->sg.start += done;
+			while (done--)
+				sk_msg_iter_var_next(skmsg->sg.start);
 			return ret;
 		}
 
@@ -250,6 +251,7 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 		done++;
 		put_page(p);
 		sk_mem_uncharge(sk, sg->length);
+		skmsg->sg.size -= sg->length;
 		sg = sg_next(sg);
 	} while (sg);
 
-- 
2.54.0


