Return-Path: <stable+bounces-241465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADf5EM0b8GkoOgEAu9opvQ
	(envelope-from <stable+bounces-241465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:30:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA747CC47
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0E623020109
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D06389DFF;
	Tue, 28 Apr 2026 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="MtnAvOnE"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D6A155389
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343432; cv=none; b=DSaSXH5Fcl/wAOyXxg2n7hPmOrWcDF65wo83dZZ85f838qPqNuY5hzxFc0Ibtvb/bzu4DO/BZR1QvXIeRWRCCQNzG6dsowsiG3UQXfaW3Q+PIAfh3t4Mx/wq2eiWWPF1K2DFt4P2I9/tOZKu9qfX3epXzv1jFbTe82kn4bYOWw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343432; c=relaxed/simple;
	bh=iMfKB7S9DNBYYlfTju4mB/Na5w4e/+oFvQOkJFMAULQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Y3cmBJ7trcfv6v7LPJsknFxyeTk+c7CCVppw9PUOoeEKcZWVxuQ6UR+HRNJ/dkmmrjdX+RFAa4QLdFWo9y2fTrkpRidHo4runw/1NHUYPAGH91UhNN9hsy66e0ngKDrXErgWLgqPOIgIeRJUWOe6ZAuJAld+li6wAt6CiXX4fd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=MtnAvOnE; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12dcdcd54adso499502c88.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 19:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777343431; x=1777948231; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VdnIHWdMxwW6OWOXeNkP+5fE1MMmo/n2Nob7Gx/eAY=;
        b=MtnAvOnE34zDgS8v8SDrd0seazhbyKCPPKzPP4sZW8tQQ+hfvwEizq78ibYH6LsAz9
         iP6STuyQPr5E0IngHDlj+uGqUlFEKTh0McPzTTJjGXAio3uZ+1Gaqe3UMmJCkegVELVK
         Gk+Uj8aZRrS4Kxu/qvd0pe0Qozszezj0EvajPESB9FbTP15VY6B9VQUv96y2OYnOFkXw
         5VKCRo4bnfE7GO+i5/Ctk9QqybS+nmC3uhpBR1C8k4JV1/kqrBXlY4iz98XU952TSW/E
         UjWkDRMskXW50Kdtz+ltkLM9d1sLyaFDOtI7w+Z+bM34aFg+TWKTtx+MxTY2Qe2MnBMW
         Ky/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777343431; x=1777948231;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VdnIHWdMxwW6OWOXeNkP+5fE1MMmo/n2Nob7Gx/eAY=;
        b=J0iiFCoGrscwxqTHSCb9bvVmYqXkaV8pthq8Qb8S1tL0l7yG+Nx7rQQRmvbuaIbXaY
         KsbNA3vhK9IxrVNjIoqsnzA41v+FxzMDuTcTwu3LxB1VySFPUn5rgXW8xAn6cpQ3C6DD
         rkgZrHMX5ZjXzk2y3huiE4f3djLtThoUC5yJxKA/6Pu+2KiqzI08ql/gvMpresZTKBWP
         4dcOMzpwdfFFp59im4/Taek7KCdPH3AmSsSWdccymdqPLL7zPLB4zEIrSwCuYdPDk3G+
         +mhB6BYExmpmFk1gj6PsH0luMsxZ7e2Vf+Nt3DHfk6nrhQGJ4y0ggjMVq+o8HACXIgsV
         VmMw==
X-Gm-Message-State: AOJu0YwFQcn7bb2ytBetmJi50W8kiYTjw0G8+Qx2C+s0AP+LDR0SsSPU
	rh1aL15PjCuW1lWHM7m/0lAr6PZ8omRDbybP05BxU4FRYoSgM5mNoRdyYkZIgvela7w4/ri+kuY
	fFV5o
X-Gm-Gg: AeBDieuRH9JiMZmDgBKsLs8R/crnFsw31fFIbXJbiOGKZB7gKUqodMhmXecbVIFVbN4
	UFXdZk4xu/jILOdn9vZRniuByvmozwpPA0ZmWAiDoH8Nb1MkFqXuJJORq2qn8LptE2T7QDL1/yP
	daj6atcGDN4cCQVsHBPb89GoJ/BJ+BnFGQLYdCpwSR8KcCOUBLtxn2d3n68ADccwJWCzZHx/76b
	mud7UklYSygjIOYxM7MmuA3NBZYRPKAoGzHYjGtjGPhw0suGUwZgEAjmsuz/VJXpKmOgKQIzrYb
	UcvgS/FTVOsSMb91EW0XxQIO3usbHsNhVm/mRXGICiqjBKkcnB/f/sendmU+upZSWbuJqMs21VI
	LtmLWy/+c1UW9N5pINuNU510efpSzW953Ji/PeGjYe6wp5+Fs+hAIX6yHUZMDSeJ+8hMt5aq0c/
	7rnBN3rjd3uw7/izK0RPESm5tsZ90=
X-Received: by 2002:a05:7022:310:b0:12c:4928:e57f with SMTP id a92af1059eb24-12ddd99ce83mr690061c88.25.1777343430618;
        Mon, 27 Apr 2026 19:30:30 -0700 (PDT)
Received: from 7f5f57871823 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd927bbbsm1139364c88.2.2026.04.27.19.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:30:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 c286ea5e62389897291fa742d2bb909ecc9ef2d0
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 28 Apr 2026 02:30:30 -0000
Message-ID: <177734342961.1574.9635512629777107032@7f5f57871823>
X-Rspamd-Queue-Id: B0EA747CC47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-241465-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/c286ea5e62389897291fa742d2bb909ecc9ef2d0/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: c286ea5e62389897291fa742d2bb909ecc9ef2d0
origin: maestro
test start time: 2026-04-27 14:33:53.907000+00:00

Builds:	   42 ✅    0 ❌    0 ⚠️
Boots: 	   77 ✅    0 ❌    0 ⚠️
Tests: 	 9153 ✅  567 ❌ 2821 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:69ef8afb9b5a9683090c70aa
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

