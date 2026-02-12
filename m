Return-Path: <stable+bounces-215912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBopBkw7jWlR0QAAu9opvQ
	(envelope-from <stable+bounces-215912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 03:30:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B931292BA
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 03:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 320393023DB8
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74085F9D9;
	Thu, 12 Feb 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="lBq/aD42"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EADC7263B
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770863427; cv=none; b=WU+mBv6Je7sNyKLcVKoocKrX5PCnGZ8W6+IUhZardtELQyK92aS0soLdNeyBRBPsiEm+DY3a7I1gEHWEGrRt63sOfsbKYteyn5mWbAD3G2JOUyj5kzIwlKJHh5SFoHYdoNPkXrVejxdpKPKLckKwcS/fTcRJAn7fa/Gb4pUx+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770863427; c=relaxed/simple;
	bh=ne+WY5Is/6WPgQ1QxMdO8zv+OZYEurL/t9WG03hPhNs=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=fSjdQGzjwzY3RGbV5z3NWuKbv4awJa1UPTNhu3QXfaZLVCcxjgnvKnpC3uhmsmTpmH6NSZRfRCrBSPVMk7eWHW3J4DP9f0VXePjm39YcFGuiG8b3b2emRro1s0MzqUrbBge7buQjG0c74SSHJNor4WYeIRYCJCk1a5pHCOuErus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=lBq/aD42; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2ba68df3687so6615097eec.1
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 18:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1770863425; x=1771468225; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWxPlz7H78twu7Rwto/k8Ts+xTIPPSmZpREtkK9SJ/U=;
        b=lBq/aD42n/PBB3DuzK9Xygul+uch2ayNGA7R+Me4sYfNpnz2Wstc7gWgUS56zoHvAp
         Jwx1+xkTCB35RFfM1j/wvrbrTAQi02GKYcX9r24+fdXf0+gKDtOvW3Ea8YKiINZGpxBj
         ceKvDg9TpTEZXoUOqDtFigTzgttKPhyNNihZznWYFFg+NSe2/tPaaPdtjWG/yzQJ3pST
         a87Psf0AvMZXGZheLLu8f3yRuFIs8lQoZ+i8ZPBmZkiADnFngjtlCixSOF6GV/J41kHK
         L7QiG6j/xhYy4mwatqOLRsx3IiFPPu0Y5+9BWmcmdkuqsyd8FnxVdN5mJF7zGjr9usTS
         lMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770863425; x=1771468225;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWxPlz7H78twu7Rwto/k8Ts+xTIPPSmZpREtkK9SJ/U=;
        b=KiFERLefFG5xX98wGSKiRrmfJqi54rVS5NMHAWXzM6MxqaYV5zo5kDtzrSWYu/5EbM
         hcOdfp2ZxQDt7iAsDLB4gXTtlRjHMqHvAHfUkiQzVWfACw4sW9mIlJr6uEUZA9Kd2bcr
         A6eFdiQRFodS9qdw6aCM4igBAWPRfY68c2otehbsHeYaMG42pggDWuX+cRxN6CNRo9cy
         aa+d4FEsVpUXTB2OscB6XF9pE3eVu0cNSuJhaxwUq6ddPVTqfvSs9Kvo5cr0MNWOrOLk
         E9SZhcMBzt088w4kol1D9dtwtUZNP+mGshcwraPg0PTjCku0UMZrxS6WqLJWvv17eIYD
         257w==
X-Gm-Message-State: AOJu0Yz4hZUDmlQma1JfGScyztWhJVxi13jIkwpBV7RHr8/JQ76Gt3G1
	nYvM2ycOI1owWQ4mQwBBE/TU+iRbzMoqIly8WtCBEHVOA70TwpCX6MNpWm7Q4qwUJYY=
X-Gm-Gg: AZuq6aJf9WYKkvxo+Qp13J80ymSO0e/oyPJF0GAR0K0f/ezwh7JDX3COqMkYMw98Z4j
	NVWChOxt3L/oDJ0DvxQvyWeOlVLdW59uFlR6BgJOFMvNybOb4nogOog5M8q+NU+Ie8pkbZUYfUC
	L6zquHSkO6OT3JJt1AKlmcBjE6aClb044wXtaT+X/qle4A3HdC3NjzLJEaJrFqQoBxMZhLWlsPf
	gUa3WZJjwJn1NkPU5h7TIMbL2wnA+Cf6XQyZyvfdDa1wiTS4nvLpumErRdw0gsYWeh3jjCQju0e
	WwD07VZ+py9S9uHxqAuGhrgTLBe/zYlRQFYU5926HUCet/AgaTRsawyVcZRBj0a5FpMvSZd9soW
	80f8tyWDhc+Wt4HvfaNO9FqBUYf/Vn7o1Ln3oqw/6cGmldF5AhQklzkM2QBB5/RuQM55lbWSZe8
	huAxUZ7ngHn4OLhFpC
X-Received: by 2002:a05:693c:3005:b0:2ac:1a21:841d with SMTP id 5a478bee46e88-2baa7fbbf5fmr690116eec.16.1770863425022;
        Wed, 11 Feb 2026 18:30:25 -0800 (PST)
Received: from f55b40a4666e ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a69cc93sm3912972c88.6.2026.02.11.18.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 18:30:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 e45d5d41c1343aad8c7587a5b15d58e99aff4c8a
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 12 Feb 2026 02:30:24 -0000
Message-ID: <177086342400.629.4627221406953162703@f55b40a4666e>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215912-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 83B931292BA
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/e45d5d41c1343aad8c7587a5b15d58e99aff4c8a/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: e45d5d41c1343aad8c7587a5b15d58e99aff4c8a
origin: maestro
test start time: 2026-02-11 13:15:31.211000+00:00

Builds:	   33 ✅    0 ❌    0 ⚠️
Boots: 	   18 ✅    0 ❌    0 ⚠️
Tests: 	  431 ✅  171 ❌  434 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:698c9489a1ae387ffbcc27e9
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

