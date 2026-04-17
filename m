Return-Path: <stable+bounces-238520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNsBK8Ga4mkC8AAAu9opvQ
	(envelope-from <stable+bounces-238520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:40:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D0D41E884
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA2BE3090C9D
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83A3342509;
	Fri, 17 Apr 2026 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="eK3U4RI6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4933554B
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458369; cv=none; b=FLaiaQxhci99xDZn6YhjarWQTxrOL1otW635tbGB0uCD5Aqmzwtbuw5T8Nvtdy9BbQ4TPKfar1oXGgcLDkdxbhrWdazpBa9qS3KrL22r0SPNBppTT5s0yPaA0Qo6T7GmN+c0zliHgScNhiPi/JFvDsEG1ElADVFMp8XHcQVZwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458369; c=relaxed/simple;
	bh=QYmKPZ5u/6MDW8voyINPo8MxBXRPsCZP02IXVl+yo60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BYUZFOvrFvU+MCLMxswD3IAgE+RImGxUVhelvEKIDCFp713p9t+QbKZvNdptn0e1i4M19d3jeqDbDrWjoXWwxekGKFIEXvBwt0WE4eRMUy0FYGj1dwqMyImPZ6MWp4t3itgSwnvKCtjL4bipG0LCX/mmS8AZCQYpN17+fR9nr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=eK3U4RI6; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479ae363aaeso66640b6e.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776458367; x=1777063167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8T8fhnGDggKVoWa5C5JOmcQbWxbtuCBK3biN6O1EZQ=;
        b=eK3U4RI6hD8c14vJUmIIMgalhfxuQs8eJiZ7JP64Jv1RJIipF8bmJ/orcVZfYr44IB
         ERRrp47rfGklvIv7bzuJaX9a1jWExK/INAxOWGCoW5oN7dErjtdRrm/+WV7sXC8QplbA
         gKkt69ZoB6t1Djtq0CkfV8j04lskguJ7skvoAdhO9pmiqnXETtGeT/CbozJG1H8KhLvm
         qF1GKSxUPp96owlDQ1/zqluf9QJQ9TCD4EToAp4YSIsbVXjACTPKOxJ6EipZYBpwy7rv
         PQIqcqp3RJxMmW/CoNMMxXQaGRniYTGTfVGnsklupPHad8/STXoUbPzIUuz0b9dS7th0
         hL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776458367; x=1777063167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H8T8fhnGDggKVoWa5C5JOmcQbWxbtuCBK3biN6O1EZQ=;
        b=jq3CrT0DscBcZRvvWrGEFAocOVLI501/AwjMSxPwrvm3UbLo5z9Rcjjp8UmV2zmXTa
         u7RB04/IYrcWBbXdgGocr0mzY4vv519ZYATRcl862PFOMn+Y7u+Zi3IjTDYPL6o1qLN0
         jmRDa+ktBy4tSXJ7VxTB3QKjX8gn5HAVnmbXBIn5BG2DAT1lHd/hm8zMywdiumI2Brr6
         IjB0vOAFKU0YlBOtHN5PgtUWWp3kAHoNIIi/JSbpi9ZpTHmrQGdCw8rC6UQ+27Y9jiRV
         Z9GGp+90PYMoudePVk8t2377hTK52TdMTnDwc/aVeDlGFHAAqKPiWvbkz1PTkjRWA1qz
         PEcA==
X-Gm-Message-State: AOJu0YzNXm5EjfwcnM06sKWFJIMPn30Jn32UEjT0ljZ6ed6EhC2jHh/U
	CzTwErFPdNzlPqA7D8vjo38691LGU/zrAOKnZnJnBpwxJJjU/FAnW2/aDgRBzo5chlg=
X-Gm-Gg: AeBDietM4IQA7eloyk/ciX65QbFD0vN3u+KyIAUvEskOey0PR/dLKIDRg52jelRy+A6
	/toG/avVx9GedcCAPReSjsU10yGHusrP+uKPA8fh/cmgswoqz3LytpuC2OSVqib7mviSUiEe4jZ
	C4+yP5+zwUexmsFW8UPi+Rqme/tG+JcwIFE9Es8o30dufkmy+D5pUgzcJXgrSNSZcmRd9qX83a9
	g4ZYozoV7TqyUvMnMsS/dEzKil4GDcen8IXV6gdwERUnZhcyVUG0qtwFnVq2UqOK/Pnip0v3J7e
	b0yNRpj/jNhqKd775Y2uwpqxzakifyHDSThAAu1LI2EdnTS0wxk83oTwpvpHRP45x74t09jWNjV
	w5jkVNC6aEcidm4b8+kPqdpgmDyonnhUuwcaxgu2Jh3rExp7du5Pma9r7D61HnQsyJ3UyE3J9Ug
	gsDI2YzC8gElXwLN8YAw2BPFTTSvuXk6CIYunvgVhPHiidmRP+lTcwXrsyQHlU6mWnOImBzKCy7
	CS0IohQpoYraH4=
X-Received: by 2002:a05:6808:50a2:b0:471:6b89:b72c with SMTP id 5614622812f47-4799bd624b6mr2093291b6e.13.1776458367186;
        Fri, 17 Apr 2026 13:39:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc9759bfa3sm1926469a34.13.2026.04.17.13.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:39:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260415145708.3331818-1-lgs201920130244@gmail.com>
References: <20260415145708.3331818-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH v2] floppy: fix reference leak on
 platform_device_register() failure
Message-Id: <177645836617.906013.5675762942401997007.b4-ty@b4>
Date: Fri, 17 Apr 2026 14:39:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux.com,suse.de,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238520-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 24D0D41E884
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 15 Apr 2026 22:57:08 +0800, Guangshuo Li wrote:
> When platform_device_register() fails in do_floppy_init(), the embedded
> struct device in floppy_device[drive] has already been initialized by
> device_initialize(), but the failure path jumps to out_remove_drives
> without dropping the device reference for the current drive.
> 
> Previously registered floppy devices are cleaned up in out_remove_drives,
> but the device for the drive that fails registration is not, leading to
> a reference leak.
> 
> [...]

Applied, thanks!

[1/1] floppy: fix reference leak on platform_device_register() failure
      commit: e784f2ea0b4fd0e7b70028ff8218f22456c5dcf8

Best regards,
-- 
Jens Axboe




