Return-Path: <stable+bounces-214336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJSIJuyIg2niowMAu9opvQ
	(envelope-from <stable+bounces-214336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 18:59:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1243FEB49A
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 18:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F7063004D04
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 17:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C68410D00;
	Wed,  4 Feb 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="cY3A1B3t"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02D40F8D8
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227945; cv=none; b=Sxb5AXLowqBcPyYGtekZSBc7Cnl054g2fLhhLrKI2FsX5JAArgZTryKL8ZL3JOoVKLl7ZmmdOnFPvtOYxvD/+fomWBJdoHVOm/HV3xzP3O2xTmKPFdVow+vNsQS825+NsKrGLSKWlV0e8/a+hMi6PdUmXgf2jLHsChYboWB5RI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227945; c=relaxed/simple;
	bh=dHgVWwo9RConpjfQNd4s7dpAZtZS6q9devc22WrinVk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=J5Y9LRM5j31mrNyRF0S2IPp2kazMc+/XA3WmyDfpW+G5qUAXJDLhbzdDpQFKNR2GlRO8smTVa/hCHsDjnKK2R+gleaELP5ljgiu1z6Tohhkad/Mt3RMjk4ajy+bYTxpdsvEel130+gyrgpv3dXyW+yLB8xcjaFDTByr/CKdAAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=cY3A1B3t; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b704f08e73so92578eec.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1770227944; x=1770832744; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CN1ThZrHikpvw8weN8k+9kehI5vmPLk53TLL6Hc10/I=;
        b=cY3A1B3t3Fl5GlAmaCdRjJt15mXlSwV+qT9zctP9fIT2p8fRrw/A+e+kbTHOaWgtby
         Ei7NE6OzEAQsoSUKOzXeNvOXi9RKIQdEhunxvL/yIoQaSSjNdIlTwb5+gs1xNyZoE+xK
         LhwyUOcMsZBHt3U8aU33rpxYBQKxiVzFnRTyr/3y+6kggYG4QarFzkabxpLQMYMJdcr2
         xLy0iHCWYnASaWbWOPzz4LcaHDeTCDYKEnWVaJopneMaJ2NVVYT+ScwevL57/tWTzmsY
         ZumBWbmJAXIeAHSRSUIlMD+u8wm3WqJ5+CaUHLkYV2TR9vROcvKLq3HurH6FCJWrYyNF
         KpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227944; x=1770832744;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CN1ThZrHikpvw8weN8k+9kehI5vmPLk53TLL6Hc10/I=;
        b=jPLTHwt/k9ISh+f/AqOJInSmwzVbFrzYJMjjugdnT9Q1le9XbBE0RsbzyyKLBL+JI0
         hn662TCaEKZQv1psz4q3eXu4oRZbqRZLEBHFqsamiSP8OR304gbsS9Ugd6KXKKdCOQE4
         xRvog41Y+y3FDM5MZey1BSFt8DOMFTDNWjM66xOfc4e1UydRWTls3MIZEDSWzVw486jN
         yKBb4qdm8wUa5/xHAG/+rVM05QYs+zXE+jeLeGdEkL1b3hbsJM1QRdcHQ0nfLNl0/u5b
         vA78HlCv5f+zaMP0E51k0IfAZDwgURSLXP/jxQ84ZhQfVny2KXZwD27Rjxth4mgZppr5
         kW7w==
X-Forwarded-Encrypted: i=1; AJvYcCVN3HXAS3yIIkr2W6XFpajsQ3B9qMPuYeJ53Na0MkonTKAxk3D/7XXjR3I/AoB17ev3NHlu8uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKp5UNZaXHINnDmP4KO+wZC3f1SAn7Q9O1P0Se4CGbSXikZ/6G
	GfKHRBZpDU+NjsQwnGo9Y5Ve40Y1epWNuWEmCAfLkFUU0Otb01o1ZaPdzt1dMJ0xYzrgkSY08O0
	11qzqXmIZhg==
X-Gm-Gg: AZuq6aJ5NlOBlny2zIcfx/pUJPqhExE2Tyo+PZ0i3Ig7EFus3NyI5s95UdyERbWm/uK
	vuofQWkrX7l6VgORTswGHEU2PcQFCP+DyAAnZL9PFRqwZlF7g82oYwivXA3Bz9NwPSMxf9kZTk5
	oqQN3vn4nBYuXElkDVBWqU82t2tydyG8wgSsSVt0WE4pOp9Y6oJ2dm2h/vewv0KmUlUe4nxcnNL
	TZAvMMZANv6P8LGRz4G/HmJtzM/qUwGA8c3GrHKONvp8ajRBznOHlYkZL2CNf1Hv5ACLWDLcB05
	ohOaVaaSRbczhwAamR27ODVCDfK+EHM2gbue/FiC0k3tYHuYWAE69wIB+eEJChhnYkf0yG9GBfe
	KIkFl79iPuR4YB30LpKGoLOpa/UzD6Euu/43CCIiTAILYMErUZ9qhxunzdx+UBy3rLJQAeCNmGL
	n4YGle
X-Received: by 2002:a05:7300:3215:b0:2b8:31d9:a8d7 with SMTP id 5a478bee46e88-2b845b596fbmr92236eec.4.1770227944298;
        Wed, 04 Feb 2026 09:59:04 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832f93808sm1994982eec.19.2026.02.04.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.15.y: (build) variable 'i' is used
 uninitialized whenever 'if' condition is true...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 04 Feb 2026 17:59:03 -0000
Message-ID: <177022794292.7001.3716577555750776270@22d5995788c3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-clang-21-arm64-allmodconfig-69837ac5a1ae387ffbbe73b5/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214336-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1243FEB49A
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 variable 'i' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized] in mm/kfence/core.o (mm/kfence/core.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:b1b47735558de7d6c0b4d6f398dff5a460d28eaf
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  28560a25ac8d6ef19933643a4a6bcd194d496d23


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
mm/kfence/core.c:529:6: error: variable 'i' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
  529 |         if (!arch_kfence_init_pool())
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
mm/kfence/core.c:615:14: note: uninitialized use occurs here
  615 |         addr += 2 * i * PAGE_SIZE;
      |                     ^
mm/kfence/core.c:529:2: note: remove the 'if' if its condition is always false
  529 |         if (!arch_kfence_init_pool())
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  530 |                 goto err;
      |                 ~~~~~~~~
mm/kfence/core.c:523:7: note: initialize the variable 'i' to silence this warning
  523 |         int i, rand;
      |              ^
      |               = 0
  HDRTEST usr/include/linux/if_eql.h
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-arm64-allmodconfig-69837ac5a1ae387ffbbe73b5/.config
- dashboard: https://d.kernelci.org/build/maestro:69837ac5a1ae387ffbbe73b5


#kernelci issue maestro:b1b47735558de7d6c0b4d6f398dff5a460d28eaf

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

