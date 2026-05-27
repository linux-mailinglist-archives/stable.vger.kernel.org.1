Return-Path: <stable+bounces-254662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NKtBoNLF2r7AAgAu9opvQ
	(envelope-from <stable+bounces-254662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D15E9BAC
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE986311A294
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE03B1EE4;
	Wed, 27 May 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwjNyyNm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9353B19B6
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911302; cv=none; b=F+nOi2Z830t43OQf+mockRQCjGFR+E4c6NCeeFFd80nd0u+bB3odyB6fcrRVPMuOJ9SBGFW3jRS3yQrjfDSuvutkm0/8sTaam6Xlm8QWO5rDheKPEiOhg7WXXpdv/7vreh87dp0o4B5bRIMJpntJbVZJ9Y45VS+5oK1TjtkY6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911302; c=relaxed/simple;
	bh=uNozSP0l8kkWDkzSOJfeL5dVpUS6xiLbgNu4M8nx/E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCmnlXG/AJEZFeOZIR/FlQxnn5Y/17bmoulgsQWoJpEp5PHSg/WcKuMgTS1UtfC51AzPbqDnX003eO9ImN4CiyUI1eSKUTcYh+jDcSfqm24w8zs5xL8HXlR572tN+2Pg59Cbvg39bCFObAC7gA2Dy738XKrLQTDNXW7Pzx0Zhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwjNyyNm; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-914db83362aso399983785a.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 12:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779911300; x=1780516100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzZhwVxQtOTxpPSV3ALvJKs3yCJTXAKgHjmBscK7oNc=;
        b=kwjNyyNm7NSJr05BtTghuEWIGyCXiQzkQBYeLthAMBu+sRjxORQgxPG0MWWdbdmSyM
         9gLVUN74jD0QG33osD9ilHrJOlNc1mBtblJpDJI7ZDqcnV3wjlecuQBYFAELqO0nC/qI
         bo7X2GZ+af8+uFp183LVXcnMWK/Q4TahtdCznOLMYNIAFvq7zedjSf8rgtSf51Badyfd
         8tO/qO/zUDVZEtQvy6BgZGFRr4xrvfkppEYr0RVwxyKnC7hNA3U60ah2ebNeXKoAXCKx
         Y3vhVWR3DNWrB3L5dR6nmWszMqX4d7KMj1aLq0xdxkGJCMKLAaWWhB1fNOGyF2achZKO
         xyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911300; x=1780516100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzZhwVxQtOTxpPSV3ALvJKs3yCJTXAKgHjmBscK7oNc=;
        b=Rl6s5vJcAI0ItMWpgdUrNLJLyWo8f0Ub/2G+tsqM6vRgr/kyM0YH9/d3eD8o8mbS7k
         82z4u867OXJLqQ3vHr4emPCvr9+B54YvhYdpPPt0MnrxJg8zmwy5skwXIGjhxumG5ooS
         KX7AkiacaQzE3qSgZOVwFxSI3gblrDQB1jytjljhz/KVLcfItd/TuendPIgfWo7mSXxf
         aUOh8oPhKRBiXw4kuyWOOr6D6Wsn+3SFtOpzfC7ouYgOZzz+L2eyhhDZfdOUy+VSoFoy
         kX2hXJ2d8DLEa6RxAqHb4xx7m0lLFGpUngcyDDstfGEtzD366fe0/y+IUyGiHH/A0AMQ
         NuhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dAYQlUuy32oZPhlnN7HaDSHEn/hOa77uX3f3SzmWD1VzYVQj20HWbDH7Js2mmu3YIyeoLGoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfrmh+aO4O9b1YI4Xd/Tvke9ilOgoUpH7LyNO6gFcat/BPszui
	CkoGmyWSSbwHv5OrthHBPWq1Saw1KZCT6UymIf0M/kzJs4gW49qwma2+
X-Gm-Gg: Acq92OGHM3ez+2bFw/hpWSPhvqU20tuwL8a/3trinG00e+t7K50yL2l/ZYK/drKKvnd
	WOxmW8G3r5Zi08ygAudSdN4faj1///oZlny2FeRHIl00FKP9EiuXp2OcqgREvEHREch7TmBu5l7
	VbsBAZ0YPOe+nlOqrQrUR6w6gXCH85Pc79ImLccgq7t5hkGVJodSC98WzaYXfTwPzwLBQt6hbAu
	SnXecWYgtnXV4doYKuHkGVF/EsdALy4q3AUDGxvPK1QxBQAWfP1+uSsSQPFqmalv6AF2oLnO/ZZ
	n+1sWLS6wQ6w0Mg0aGBymY0bGlFpxz1+xfUstaQDYzDFjBjeAz57TjUZwI4bAkA9eka8+/JzVJb
	aXB8UL2n6btt6ZDep21GTAaAEhO4ZBzGYJs6VTwgOk6bLZOCtC735oI0Va1hgbki2ysUGipfVeZ
	bCKLATy+3BxVzgzJJllq/hrrh6zgSZB3lc8mZuf/b0tHY1m/VgQ20OXYQaBRTtQPjibxIYQJ5DM
	RPNwYkOecHmYGryXxRNXXqTd5tkTh0r2dG0FmW3FlEsXuJ7sjYwf1D+duHO5R4i
X-Received: by 2002:a05:620a:462c:b0:910:f8b4:8614 with SMTP id af79cd13be357-914b51668bdmr3081086285a.31.1779911300034;
        Wed, 27 May 2026 12:48:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87017a0sm564942385a.15.2026.05.27.12.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:48:19 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] media: rkvdec: hevc: guard INTER_REF_PIC_SET_PRED index underflow
Date: Wed, 27 May 2026 15:47:37 -0400
Message-ID: <20260527194737.1999409-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527194737.1999409-1-michael.bommarito@gmail.com>
References: <20260513181922.2075438-1-michael.bommarito@gmail.com>
 <20260527194737.1999409-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-254662-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,collabora.com:email]
X-Rspamd-Queue-Id: 862D15E9BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

st_ref_pic_set_prediction() computes the reference RPS index as
st_rps_idx - (delta_idx_minus1 + 1) per HEVC spec equation 7-59.
Both operands are u8, so when delta_idx_minus1 + 1 exceeds the
current index the subtraction wraps and the subsequent array access
at calculated_rps_st_sets[ref_rps_idx] reads far out of bounds.

A userspace V4L2 client that can open the RKVDEC m2m decoder can
submit an EXT_SPS_ST_RPS control with INTER_REF_PIC_SET_PRED set
and delta_idx_minus1 crafted to trigger the underflow.

Reject the entry early when the reference index would underflow.

Fixes: c9a59dc2acc7 ("media: rkvdec: Add HEVC support for the VDPU381 variant")
Cc: stable@vger.kernel.org
Suggested-by: Detlev Casanova <detlev.casanova@collabora.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c b/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c
index 3119f3bc9f98b..898d1ce74f38a 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-common.c
@@ -268,6 +268,9 @@ static void st_ref_pic_set_prediction(struct rkvdec_hevc_run *run, int idx,
 	int i, j;
 	int dPoc;
 
+	if ((unsigned int)rps_data->delta_idx_minus1 + 1 > idx)
+		return;
+
 	ref_rps_idx = st_rps_idx - (rps_data->delta_idx_minus1 + 1); /* 7-59 */
 	delta_rps = (1 - 2 * rps_data->delta_rps_sign) *
 		   (rps_data->abs_delta_rps_minus1 + 1); /* 7-60 */
-- 
2.53.0

