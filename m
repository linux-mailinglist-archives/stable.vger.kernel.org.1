Return-Path: <stable+bounces-76519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC497A6EA
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DBA1F24618
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7936915C128;
	Mon, 16 Sep 2024 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="krt4n0/N"
X-Original-To: stable@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED215B555;
	Mon, 16 Sep 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508519; cv=none; b=MYpxi5kk9HZRqFrKd8tCkZSOJecfSBfDMqKT3fTk/n8EK6It/9GbvY5LKyT32hpyULCpJoVJzoJVV8JbNZ2oziNS+uMaDgWSCuKG7PNDCtfft6leG5aaFRqcQN90EgSWuo6/4/jJSoA5rK2c5IPZkUy7XxUQzl9ozoc7LBwjYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508519; c=relaxed/simple;
	bh=+rJpvIPO5yEsP+zpBqSixjqyl57HlBrna/VFYv2U+0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UBG1WEMH9IPwYmzWPrrg+N7Xc32IP+WwWN2yF4C+e/16+uVS5BpmSDzaY3+J/TyohmjCU7TcKdntoR8aMUZ7NcxG/jYy8kaa9fMGaONcqreYnBO2JMGg3AEZwCIcJSeUarZjiuiLCd7J1gmZShHLl3m5+PMt1N6t+oUMUUvKbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=krt4n0/N; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id AB179C0002;
	Mon, 16 Sep 2024 20:41:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru AB179C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1726508511; bh=diCzsoBGaJDuxCaIPlitAIbV51E2AV2hqaeEV0ZPrl8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=krt4n0/NCcaayPy9QC6tuignGUAnkm+YPpwKWiTtXkhrq6Gyqz3WTdtTQgRm99ZEV
	 uFPBcuTtcP7lp6Kmv1BPIUmv6JhxuSb01GqYoK1btsgbFSTcHu/hPOt0Sbb/FkUt0R
	 yEwMeYgxfjUfeSC/zk8Qvgg1FIWsQMw8K54nzN2j0b41mukJ/Kzpk+/OozmmaWlcIm
	 HFaNf2bw8VA1hYQa5G3vu5PW3PDgLuBXWIwg4PuW8CP0U92QFnGGw/f9utD/VEtlPp
	 CpiiJ4XotzeBq/hOhbsTPSRDNLYAXwZRutFSCr0793sEBMXd4uwAuTsr9Fjm0IKrrw
	 lJ3ujf/JCK32Q==
Received: from ksmg01.maxima.ru (unknown [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Mon, 16 Sep 2024 20:41:51 +0300 (MSK)
Received: from localhost.maximatelecom.ru (10.0.247.12) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Mon, 16 Sep 2024 20:41:50 +0300
From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya
 Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvmet-auth: assign dh_key to NULL after kfree_sensitive
Date: Mon, 16 Sep 2024 22:41:37 +0500
Message-ID: <20240916174139.1182-1-v.shevtsov@maxima.ru>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187775 [Sep 16 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 81.200.124.61:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg01.maxima.ru:7.1.1;maxima.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61, {DNS response errors}
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/16 15:27:00 #26597375
X-KSMG-AntiVirus-Status: Clean, skipped

ctrl->dh_key might be used across multiple calls to nvmet_setup_dhgroup()
for the same controller. So it's better to nullify it after release on
error path in order to avoid double free later in nvmet_destroy_auth().

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
Cc: stable@vger.kernel.org
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
---
 drivers/nvme/target/auth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index e900525b7866..7bca64de4a2f 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -101,6 +101,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
 				 __func__, ctrl->cntlid, ret);
 			kfree_sensitive(ctrl->dh_key);
+			ctrl->dh_key = NULL;
 			return ret;
 		}
 		ctrl->dh_keysize = crypto_kpp_maxsize(ctrl->dh_tfm);
-- 
2.46.1


