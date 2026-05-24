Return-Path: <stable+bounces-253987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePbdNcJiEmpIywYAu9opvQ
	(envelope-from <stable+bounces-253987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC75C121F
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E88A2301301E
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A5F25B091;
	Sun, 24 May 2026 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="S5VDNZXy"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134A2192F9
	for <stable@vger.kernel.org>; Sun, 24 May 2026 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779589822; cv=none; b=K0mb0V8HVfiOQsXNJXsYcBUYqFMdoNyglQSIPL6jjbz6rMcHbfpw3KaZbdfSaJKkUCKcf9xRgenF+6SF2jQOjEL2qPiTXPlufKvkpNCRrKZpxbM0SbdZV1klHKXtEvKVlR9r6q8cGIhDK0aFSuOgNV4Vougc5A6fKF3ga7u+Swc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779589822; c=relaxed/simple;
	bh=sCWUTtNUii2mcpiPa2+56tmfC+rzzc+/JP/K8vKdaIk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=GmOpgUE95t0qVaTigm32oxLDfDmG228Jn4YX37md9SuJinG9//VOOXFFoDxAmQKi0YSufxEJU+LY2PDGoy0uWtBp7RBUv4wA7hw3+09viogrEU8pd3NOkULsYpl5sDUIin+aEmz7ms0L13jlURRWY916yfm/c8BoPbNsKLOo3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=S5VDNZXy; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304545e6c7fso2073533eec.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 19:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1779589820; x=1780194620; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfIdi283054yTpqj/Qe4wB/bLoslHkEr501pPNYlKB8=;
        b=S5VDNZXyIlj4fEcgGzZ4D6HdA3NdylNzM/ukTF1LitbAFYW/6aAds7IaWIVY8h0Hoa
         lwOyLsHp41Y00oJRpUNpFmWeWAo/JIw7DNgl6RHwTEgJFWR7bgOWZ7hvtI0epKpH4Sy5
         1u/EmkkpKS+Y+7vtxpdKxi5MQaNnpPeoZmGtIvZIPm1LLZ6WJmaoSKxURn/h7t52b/cJ
         PUPK+lrY1VXyfOeRNi3EOC7ktDDfrpzupAemTBjX7A+lAo0Vp9zG5K2CUUAhGTqf+8av
         B8jGl5MtO7Bc6Bi9GpLeIYDhl6Sd4hQSP7feDCihTrBT2AbgUe8/mu4vBDR2P9hC3PZv
         Syag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779589820; x=1780194620;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfIdi283054yTpqj/Qe4wB/bLoslHkEr501pPNYlKB8=;
        b=QZH/gqE/LDnlymkA5Bg06yKi6nsNXur/m2xToSI/IwqO88hirR9h0fHOo5f2zLLPJb
         S6qhTbofcu9YvmyAsrQQQYsBM+vdeLUBwx3IPXaouFoJ2YokGNFpIB0+spfxok97qf2E
         B6zuEpuaBWXCcp9xBe5drec0Vz/V/ETZZSHqeOMTphV16RGICg2HFbjJGGID/SKf3ncJ
         w9KnOfMtfKj+KEw3b5WZaxt/RiM0mL/Fp8rqZ22ZXfJ0c5rAnqKNfKH2Y/GF4QNsobv5
         Luq50aTFc/2kx5qx66w9vD4E4uBVw3tYsSNlLYl+7vG06TlNM3zE1F8/N5X40kihgk0q
         tPXw==
X-Gm-Message-State: AOJu0YydFM91JQteKOaU08LUIBNyG5kJjIkHWy7Vm8dlmE+HLvHGF1gM
	L8tUVCkCR5M7UPkxcHwBcayITe6vEUIGw3drE4UBymvALWJg8KU6bY2PyQ/z4V2B1ZMLnazJECz
	Nps6N
X-Gm-Gg: Acq92OHK+yr4db0RPjBWt8AKX+grE6PAoTSB75CrqzzDnSwW0Hi154OQi8GR7skPnj4
	bIEByiBoptGRtYSfsGbKDH42xn87kVp7DShqq2zPRZLBuBZqjGplyWm5GkQX87bQM0O2NjXooZd
	0C0pJMz/VgUDwaMVm0XGsLIAbRogqDZ4cP7yttJppmgOEFOumTV9l3rXC9rI5kLubYlqTOBl2cO
	oK2aLvUnYAfL6AbYBtKVJbVeTuWkRHr14H9RjXl36sLwA7O6cKZKIfc8GfhAd7vLepKpPioPIZd
	bmq2eEfNk9BBrj9T9ocyQ8FqQfahIVoYpy2WwQ16ocyQJscoy76+088U2odY7jE6Z+54rAUTzjd
	bbTejFQdsx/l/Y3dXDZGOj1XuflJpPYN/+rw0MHR/z8ZhiR8yBQa+rGTeX5oP/G1n3ycfcOo2eu
	xjGSZ6eQc4gb0fnaui
X-Received: by 2002:a05:7300:a903:b0:304:2af3:5ff2 with SMTP id 5a478bee46e88-3044905c53fmr4375689eec.21.1779589819955;
        Sat, 23 May 2026 19:30:19 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245fbeesm4709652eec.30.2026.05.23.19.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:30:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.1.y -
 dcbcab9d707928cd1679eba21ef0697fbb73b88a
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 24 May 2026 02:30:18 -0000
Message-ID: <177958981858.4906.16672243747529070100@330cfa3079ca>
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
	TAGGED_FROM(0.00)[bounces-253987-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,kernelci.org:url,kernelci.org:dkim,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 8FDC75C121F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

Status summary for stable/linux-6.1.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.1.y/dcbcab9d707928cd1679eba21ef0697fbb73b88a/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.1.y
commit hash: dcbcab9d707928cd1679eba21ef0697fbb73b88a
origin: maestro
test start time: 2026-05-23 12:15:08.086000+00:00

Builds:	   41 ✅    1 ❌    0 ⚠️
Boots: 	   45 ✅    0 ❌    5 ⚠️
Tests: 	 1715 ✅  146 ❌  806 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11a3dd5bf5d05c9744ef31
      history:  > ⚠️  > ✅  > ✅  > ✅  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11a5975bf5d05c9744f173
      history:  > ✅  > ⚠️  > ✅  
            
Hardware: imx6dl-udoo
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11a5985bf5d05c9744f176
      history:  > ⚠️  > ✅  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11a5175bf5d05c9744f101
      history:  > ✅  > ⚠️  > ✅  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

