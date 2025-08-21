Return-Path: <stable+bounces-172226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE32B302E5
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 21:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFCC1BC6AF7
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083841A9FAB;
	Thu, 21 Aug 2025 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GpGEFm8M"
X-Original-To: stable@vger.kernel.org
Received: from sonic305-20.consmr.mail.sg3.yahoo.com (sonic305-20.consmr.mail.sg3.yahoo.com [106.10.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D672634
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804705; cv=none; b=eUs0G5oftazkL174o3wJ25WYv2f/5mdjAqoHL8wYkC6nEE6Ta1lksRzyGopTPRG7wbIQVjbzdxZcoQSVthqwdcJVF1VDYDjwVXp8mHR288dfFkqfgLnJCPczD3JIA6K+B43KK8sYT5zNq1k+G94dLWJroz9ahdmCZ19QdwOVczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804705; c=relaxed/simple;
	bh=79qMtTR4pCr7m4hgzi1TMnj2YF1DzyvB2hWRPAcN4nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdMsi97ysaCasI1WJXdJOTE4/dbEq2PFhQfA3PIMnS0uX1BT5vleMVz7vTmzkejJuAUGOqyRtmY1r5vmhq+PDwIYIJN/FBUdFdQFga+sJkavx1PqHT8f90F3XbSv58zEfVII3argPLfCHM67/aDJ0CWsnYVgteruo+ebKdJowtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GpGEFm8M; arc=none smtp.client-ip=106.10.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755804702; bh=79qMtTR4pCr7m4hgzi1TMnj2YF1DzyvB2hWRPAcN4nQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GpGEFm8MgpGPAsOzLsViBg5wFF/7SjJ70YZ5rXRpZInpPPtMNt7HEFNKLu6lodzA/Gse7IE+bsPnp6kmGy07olkygdkJlr5rmLdqFr2IBsxQ517OZgjasxopDSsVoZ7iks/giSM1FTGZZpqucwylZ+AstqsyEb7Er4v13iVElKJFN5W+j73zQJcSfY4t1pfD0RYobbriHuJWZ48KWt3YXGG6JQUjN7buloGXly4glK55aBfsY6kE9AqNAG3P4mUEp0dmEouLPJJ4b2Vc6JGZsT6eqJYLfh5ky7X4AZ/oRdgwQq9GKqZDo0Q9jWcrVVxTM2NkK0Oz+X/vKOBqDe+5AQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755804702; bh=ycjVxM73sXGAQ9TZmDftpj1h167CfyrNVit2rc9kCVi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QkNTdHDSlsxOBmuvh/z4MF5QCfH37MSgsAjq3qWabRxbpuTV3U5NCxwJS2awF+aSQSHG074rPPDkV2Chs6rsjBAUy303zayE9GYIeNCDmLMPRoA52dYW5dTmyUew1fuiYF6faDTf1CSs+zZeAsZmc8cIuzep1Qxjtf8wrGs+u0o2U5ByHaGWadUAOyvrNnZTPpP9enzCxMgHxpqdat9LPS2hWoKmhvZ4xzOiAYc8WJqasMJMbugYde/xhdsPGMvxKtKIm6IR/b+4Srlqq00VrX+ttTdcbQyeoACpsy/841Ms3CtQGgN6HXlnOQZKZifs6P7bQUk70WiaKoUAtRoIHQ==
X-YMail-OSG: TGkLaP4VM1nLSGOtAxOAS8DHyIaqeUWcqNZOPGYGG0qgGc88Piy6.qOfB8krpn4
 90cTgZMSR4yOSsmNxBT.HafiRoj8pv38t.FJMAnNGxlaYJQjsiQgOdPFJo.jucGY95rwD4meJyW_
 _ICSRtIiwstQHuUft5rhAOkzLQMk3p2C4bRxHk2GXQktP5s_eYkuFEgToAGnPmFM4QYzzfjpPwbL
 LKqACYkAQWTHaH86ooHOoa7ewdi_B4JvOBmxlAx7No5ZrbrqP2YegiS39Zxx67zFiJnbvxZpsCRh
 Ka0xxrjZQGfA1sHpz2q70VKMpCZJHuVkk6_LI48NU9zXH_.mOA8AdzxohkfssObl.4mG5q7fsorX
 dY4pl8U5wWt8Ak81icHDxClNLnw9lMBFd_PL6j8Ii0AcJxN5woq.WxNSjzcgY5EM6qSiFQer32T2
 BU_TDi6v5xhsSMbyroX8CqZqHO5mnLB20rS2YTs2C0eoAK.XCX8p8Oyhz4z7crXmmEXb.1EckWA_
 RZ97d0l_0ylunFvLADeua.m5jmI2agmyIWV6BVpvdZ99i8daqStJWrIdDlZjgmC16VUMEEAE4Q2S
 SaLa_aIIy7eLlqHuWRn5yhWitVtfYRN94gCAYVyRBAyeJIneuCFsRXTDx21O_bcBi4kYbgWYQzv.
 P5ASZewYO6S.cmTHczJMz.T77PBxGi6DkTie5TydnbncrIjSO72AwgzHtdYyNhr7I5ObAaaO5ts4
 UJBCShAQnm6vg3PcpWV5TbiGlTBrV.RMLIgy87Ew3v_oe4rbSh1lnF4y3udBIsYjXjtVhizSdFDK
 tsRs4tOHcOUnuCOiU1sjBmix37lcrTCTFnaZbbtsKjj7HBovxc9AivUPC.wdTTp5RvExZJWR85q.
 PF1cAFesb9oBSco.BO6_CZcDNIwvyXPve1EPRokx9ONUitNyoDiZ9Z7yU4C38zmjXaJLvcE48AJF
 S7LEyTtfZ9u6O4Ck_MBcY0H0yLKt2VPceQ_Z4k59HNbGkTWFEGcdvnbET3TjCGhEeKLQVH3U6hsa
 v.GC94Xt3nbKnIYbY17eoPgMTqMTP1BmPX78g1otx2_SGi.atWRjOsiX6U4jOlDkya5e5GbMRJr8
 ouXiFrT4SYP76iPwAdagYQDpAs._Gjw450rsJFOkff_gQalXDQTA35gBc6tbbDFrTL_jhc5qwKAx
 28EjdroxkhlasGuc3dBZ5fN48UPBCt4lHTj5hfGfwTfL8QzjQemkyOLps1XRTGWROmuoRrM32TA7
 ND5o2z647VXd0v6A61k4G6j38pn0oQInKKbRzzxHMg.rK2nPyfb2cOo71V6ZCw5IOMmWeezaSoAQ
 qkCqjW7XKdp9h_eYUF56Qo41wikuKywBrd96WSjOC6K.4xvL69Sim8FU9B_kfrvWDAwG7HSStiEI
 IwfMqVQomTM.T6r6eslCdSkysJwmQdvc4y7HBUI2syg1_86iavOM1b0YSMWyoz9y89gVf6k8C0It
 eEZAWaVnO8GIStST1AyR2GrQdg66L.FJxxPI_FK8g1sTMdj3oDACjKJhqBxF_aANlhV54yRmSZ89
 mDNAtfsv2Mgxl9OBFjE7nU1jTXogGD8ZtUU.ECQR.r7L1lipScsUpl0ruQ_qAcgGlJK6EFW_wmBc
 _mEEaYjA_6zbwp1ZB4o5cMHatO9FKpKYoF8KL4ggG_JbNsp4j_Mu_dtJ1cwuV1gijA1NKNbrqE3q
 KGdWcOm6ABXRKyW3v0nNta_fspuOdraxvb.FnofKYMtJvCIC3Q6cUuRlrRZXh7iHkYyJEh3ZIPnt
 vKnob3ixMwGHJbjt_t37mqmU9uHoxC.rVcXvAKnddyO2VQPd2FllepKL5REbkcJO_cr8zZiTGGMR
 YHaJf_M9tj5jQ4JePF5DDojWWKmcnn0Dd.1Y87L6sqJba9BpNwFl6649i_iLbCbA1G8IdT5c0hrp
 FzphVREkqdLWHDJM9GzV77eEVovGPUHqNovpDEwjGNuvuKeuKSTkSoPIBI9x6dDf5Ub9zSvUEitI
 .3IzsmzCEoM.UpzTRIfHffnWDRxHy.6V4Bb6NSbaRcyLsFQZd0fWe.ayWaxvAcW_oUF68EjMVGnm
 58Sq0a5iBZD.S1YYYo1AuEYp4G9JIG.Dqhccs8njbCiK.DiPR43APsPHxrE_8vEndyNK5hxKBs3k
 59h1ujBOoZwhIgILrHa_GkbfviOod.z_hOtj1fyK4fHq85Z5KU30enyehPtZq4bhn_EbaIxdWN45
 dE1IskItp9eUX5_g.qI_qLRDsVWcmbdtOG_hLhyY1iyrpeN7sPH0JqpC1mu.H9Ih1tjuRdWHwPdi
 MA6htqxlmboKpzVMKkA--
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 5ed3eba4-7b80-485b-9dff-9c2729790cd5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Thu, 21 Aug 2025 19:31:42 +0000
Received: by hermes--production-ne1-9495dc4d7-dbtfw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d67fb2e8a117233158f28e86817b6c53;
          Thu, 21 Aug 2025 18:40:59 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: sumanth.gavini@yahoo.com
Cc: boqun.feng@gmail.com,
	clingutla@codeaurora.org,
	elavila@google.com,
	gregkh@linuxfoundation.org,
	jstultz@google.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	tglx@linutronix.de
Subject: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
Date: Thu, 21 Aug 2025 13:40:54 -0500
Message-ID: <20250821184055.1710759-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812161755.609600-1-sumanth.gavini@yahoo.com>
References: <20250812161755.609600-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

Just following up on my patch submitted with subject "Subject: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit".

Original message: https://lore.kernel.org/all/20250812161755.609600-1-sumanth.gavini@yahoo.com/

Would you have any feedback on this change? I'd be happy to address any comments or concerns.

This patch fixes this three bugs
1. https://syzkaller.appspot.com/bug?extid=5284a86a0b0a31ab266a
2. https://syzkaller.appspot.com/bug?extid=296695c8ae3c7da3d511
3. https://syzkaller.appspot.com/bug?extid=97f2ac670e5e7a3b48e4

Thank you for your time and consideration.

Regards,
Sumanth Gavini

