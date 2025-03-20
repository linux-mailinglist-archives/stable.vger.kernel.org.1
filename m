Return-Path: <stable+bounces-125663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93849A6A889
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8233AEBBC
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9BC1684A4;
	Thu, 20 Mar 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XC+YA15D"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9215C6A33F
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481085; cv=none; b=gaed4l11y2dnrBvXdhUyuDkgxCCb+xeLUQNLeY6u30Pt8OhjcOR9RriEvWdm1oY+odLwQTj7e6ZbRpVs+TayWsZqnNrdYbRHsMsb9omhdGZKeaUQM0tfQFj4NYVCTRrNOwYRXC8gMRNSrfyS45NzbbQTuPcAgVWbwWnCki1ZVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481085; c=relaxed/simple;
	bh=3CHNjWoueBLbLDZLpfNs+bhOpWOCPmvhUc/aFQKcApY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ciY6HPBj6TmvPZer8Cwtj0bQxZ/sl3OGbyi4NriENFPdf46VMR369GJUmdr9MDu1dil4Ak7+mOoHT83XXBRI7Kd7XFTRcWTF79a+JvFd3yYsWTmDLAJAPMjm/ql0eu0IfmSj+28/g3rKL+guGOAmaavSJXVNr//tqm+1k8qZbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XC+YA15D; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3996af42857so1335818f8f.0
        for <stable@vger.kernel.org>; Thu, 20 Mar 2025 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742481082; x=1743085882; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3CHNjWoueBLbLDZLpfNs+bhOpWOCPmvhUc/aFQKcApY=;
        b=XC+YA15DM1oQsGQxp0KvksFJKuLNXZEG0yV1CbP1Nku2PdR7milXKdvtssNH685j3+
         SyvOggzcp629eWQ9IUKGMM38LorZA3xJMZk91Wv2jTswodNY/bYOxRZGTPbe58OLEZqH
         KyCKUW24+5dbsfv8wUG3iLKnntYGIeAIeysw4DasT6klD5ZizBBLB2wbgKQr9hrT9huC
         u9wvTYHn9o7xW+socBVv9He/xEPOXYsc1K/zeGeOrB+nKT3qtYUU5gl0pT8V4fAG0GqC
         3kCPEOaeWRXss3nsSlBpRfT3jyA/s5QkBx3Wd5Y5fEDko69IDGs0I1qaKPOlnhTPsjBA
         Lixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481082; x=1743085882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CHNjWoueBLbLDZLpfNs+bhOpWOCPmvhUc/aFQKcApY=;
        b=bYUiSOj06XjH59EJvs1/R7d7hAl34jPI/lq/7v7rE3l9vh4lNi+nrXTDYSRM6kB1Ja
         0CifxC6biYtewezHt7JbFIqh+3ckqBInQe0JxkIfqYU9F7iMgg+cELzMphPXF2/cEbe+
         m8/L+jpLJo19Hko3ovfA9a24Lql1IqUnhbVOKA3StZXuHyvTA7W2pNGUAZUAHXgiQwYa
         vH1Dr4jgEcHoYOc0sVxE+asCwaRnNIHvEwSFlXL1fKmEJsKU5OH4pf4RjYq/JTevsTCR
         OOB7cybT/tJmPE+DNxjN1hDeiJYN1EQwI72Ebwsl3ayKv40GxZ+FfMPd8lmZJ0SCOnRC
         8fNA==
X-Gm-Message-State: AOJu0YwRRbbU4+Khy0aVa/LCwsECn1DvG8T/3+W4yq8/71J41/W7GXW2
	V9VkI0Zpw7No+6+Gl9snVLsRpKTktTjhcvn+j1WyuVKqD9uNFs7/l2eaJbAKnSvCduSHi/BTROk
	TcnI=
X-Gm-Gg: ASbGncuOlPzIlB/dBgMwUmp65gCyrWj7FCCX/9fHazdl//ObzK5fpvureeFVt4gG4ng
	EMo7RlcVROa6mdx4LSbZMqUA9Csdx1VbNMea1Hwy5+i56KCvNqOxFMzgOkpO6DDJ9HgluHU8TTH
	HEz5NzxLTdDk+OoU3tZDwX55ub5eRWBi7At2hMoKHXo+RNIw80iWsK+kSv3hslkeB4A+aXBJXp5
	r3OkjnALDtzZq0ji3PIJ/3lfBbhPUCkRR0D6bU23V5SbAujNI9QZOLanveCkQkgeZG/m5gdV1n6
	NY1n9YMivnwwtHH3pZXIZFqDb1R2HnezcKmA+Ps=
X-Google-Smtp-Source: AGHT+IExwvrQyry/JWwWtqjS+PUdMZLpyZW/AeonUnJCOBJBNf82ROI1NsMAkejpxBGPoL8zUNdamg==
X-Received: by 2002:a5d:59ab:0:b0:391:2884:9dfa with SMTP id ffacd0b85a97d-39979575675mr3677121f8f.13.1742481081613;
        Thu, 20 Mar 2025 07:31:21 -0700 (PDT)
Received: from u94a ([2401:e180:8852:a021:9b71:2de4:479:d6cf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22637cf43ffsm53342595ad.129.2025.03.20.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:31:21 -0700 (PDT)
Date: Thu, 20 Mar 2025 22:31:16 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Clarifying stable kernel rule on selftest backporting
Message-ID: <oy6rjahx5grqer7yfhts5y2s6mivgjhevf5gtgkzlytiqznk4i@fglskeuhoilh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Do we have any rule regarding whether a patch that adds a new test case
in tools/testing/selftests/ can be considered for backport?

For example, consider commit 0a5d2efa3827 ("selftests/bpf: Add test case
for the freeing of bpf_timer"), it adds a test case for the issue
addressed in the same series -- commit 58f038e6d209 ("bpf: Cancel the
running bpf_timer through kworker for PREEMPT_RT"). The latter has been
backported to 6.12.y.

Would commit 0a5d2efa3827 be a worthwhile add to 6.12.y as well?

IMO having such test case added would be helpful to check whether the
backported fix really works (assuming someone is willing to do the extra
work of finding, testing, and sending such tests); yet it does not seem
to fit into the current stable kernel rule set of:
- It or an equivalent fix must already exist in Linux mainline (upstream).
- It must be obviously correct and tested.
- It cannot be bigger than 100 lines, with context.
- It must follow the Documentation/process/submitting-patches.rst rules.
- It must either fix a real bug that bothers people or just add a device ID

Appreciate any clarification and/or feedback on this matter.

Thanks,
Shung-Hsi Yu

