Return-Path: <stable+bounces-249170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPkVErl5Cmqe1wQAu9opvQ
	(envelope-from <stable+bounces-249170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:30:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE356519B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E27CA300145D
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84BE370D41;
	Mon, 18 May 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="NkAxsCR+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6792372EF6
	for <stable@vger.kernel.org>; Mon, 18 May 2026 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071411; cv=none; b=QmdMLSxgALq1BnUF9CUCVzo1/kgH7FcIMwhGkiK1CHDzWM++517HZms6LyCTcAl897gtvgBSViOu5KDXgHwFR2ASCxnrR7njh4t4DefI+Ra5+ah5M9kO4vsVZGm23sqV7syxElHDLSyQjK6xOXi1xT4pUgiytnd77CqAOxYuz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071411; c=relaxed/simple;
	bh=7CNtfjQhsmU2rthxkC5TMG29qFMV4mirICuzNK1PDF8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=jPUppcMjHTCVtvNg+106DkOzWwX35ofi2tV5n4rosavgne/JygT2nNRz0siFnI9ISXgLbq06jtgGYNVvcO82TxByUyVDSd5lTWLLVCjhamYAD2ZCN5OPOYM4xrK8md6EHmqISHh22UbeQSas9Eh0Z+gmqyVqd9mC0PLxnqRFkQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=NkAxsCR+; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ff5472f263so1526679eec.1
        for <stable@vger.kernel.org>; Sun, 17 May 2026 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1779071406; x=1779676206; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHt6G5bWJ+IqSUlcDU472f2pLpjykVQst0aXGpa/C9Q=;
        b=NkAxsCR+KpzhdQbAtjue0iV51CsnHmJJacEW6Ml4iuwij3PlcIg6I1Zcp3Fy9oPeEC
         Scbi6VY2ZXKaNqKKIRgd+piyjL7imfs1DbHnHs/OK8aNBcYQlBZkubg9Fk3E7PMVxWon
         QiCFWh93HEO4z4SU2lIMZ9McdbiDxU+PH6c0MpCkD+6FMYxDptXHVVrr/+7f3cNOMIM6
         QjVQ9d9eebVmHmnBoRqI55cfZBf4hBSc+0KWzbr0XfE9umbtR7zapsdnSKiHcJ0O9Z+7
         lzqa4KuxfU9Qr9PZmx0qZciVzEx4Awzkz/MKjFWkky3MGIl/Wu0iUGjLzcCLJUK8UlkH
         fpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779071406; x=1779676206;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHt6G5bWJ+IqSUlcDU472f2pLpjykVQst0aXGpa/C9Q=;
        b=afxeFrG0YAkYdBWKUwtyFrHM5Mn13e+2qmaszQ7hbmi511/HHTkHveb2oQInMixBLE
         b5Irnd62Ugg7PSeGeg2ElUoBzt/8gaynz7nrULuixSWMs/KP5Wi73kaxmLMf6Ypvl88/
         bIsIJ5Heo/PhNTdsbmuxiOqVaoKbNQxl19YEySfymtcEdiryWNfj559mpXMmIb8njSkZ
         URTTdTGvYmkgAR37sgBf9lF1riQRuyPZBQPfuimO3LH4NclsUMIZLqBLrwxxg7kabNm1
         j1MvbEgpDb+Tsn76tc4gVQ4CdfQ4lLrqsESSLgBSOuMHXt9KBctZqisB5HYtK2n4FMeB
         5hrA==
X-Gm-Message-State: AOJu0YyGIsOaefwKQWjiJaoucynXagbQJai8kDwyaoRU1Ymwjer/sVqG
	fvq8A+CtEbGGHn/tUFXwV0hJf7slhVrhx++XzvNo3fdEfpcp2eY0bozot/n+U29orp4RxYPwsu4
	bPDsi
X-Gm-Gg: Acq92OEWufYiiYs4WZHSSo4oCQekMmZ/+D59oQb3uJmTAbuLHrAWICIIkPi6xur9GFS
	L4VNWJKp0KWKWxKDNpMW2G8IS0NgbCCqe2gpAEmGksLDMeUEq5eySpDth+Snt92Md/C+bY36v9a
	ptF8NHoCScOyGktKx4lLNJf3eQbEsBvLjw36P7dm+Lg9e1UEwo+ItOp0eTHLslP6iZsbhPBj9PB
	jTr0KStBRozkV9L5inyZJpl44wcRwd7gjPUgfvtGlSVSlTpTmN8a9kzWw2HeETHbzdO+JcZwG5a
	kL2MNg235ym5oO/qw5z75gvF/wo2CzC8deLrfV6i9ldvyI994ZH6JPTn+skiuCP2ocJOCagkGnA
	kYsU/s7J8Ps67g9UrJ5N2ep5M4T6l+5jomZ93BaG/AcWT49n8IDBgunB6MHBE0MI2E+Gsy2f7XG
	F6G7//G5R1U8RLOmcJ
X-Received: by 2002:a05:7300:ec11:b0:2ea:c085:44b1 with SMTP id 5a478bee46e88-3039867f4d0mr5533156eec.19.1779071406297;
        Sun, 17 May 2026 19:30:06 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm12664182eec.26.2026.05.17.19.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 19:30:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 2538fbeff8a94ee2b54eb09d92209e24a1e650d4
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 18 May 2026 02:30:05 -0000
Message-ID: <177907140508.2148.4899475057510016321@330cfa3079ca>
X-Rspamd-Queue-Id: D9DE356519B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-249170-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/2538fbeff8a94ee2b54eb09d92209e24a1e650d4/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 2538fbeff8a94ee2b54eb09d92209e24a1e650d4
origin: maestro
test start time: 2026-05-17 15:54:39.219000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   74 ✅    0 ❌    0 ⚠️
Tests: 	 8644 ✅  566 ❌ 2769 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: imx8mp-evk
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:6a0a20570ed99f002e99f2c2
      history:  > ✅  > ✅  > ❌  
            
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:6a0a0e8b0ed99f002e99d077
      history:  > ✅  > ❌  > ❌  
            
      - kselftest.kvm.kvm_memslot_perf_test
      last run: https://d.kernelci.org/test/maestro:6a0a0e8b0ed99f002e99d028
      history:  > ✅  > ❌  > ❌  
            


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a09f17a0ed99f002e99976d
      history:  > ❌  > ✅  > ❌  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

