Return-Path: <stable+bounces-158206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF783AE580C
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 01:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198224A0BA9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE722DA06;
	Mon, 23 Jun 2025 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="itLrDnJ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD37229B12
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721575; cv=none; b=rr1mcO4x9IeVje7RlL0i3KVc1x6nyrAhDohVPIoEUMXzskktM7+BB+/78oZQdRA5Zcr/N3T+k+D5ezMghKRU3loasIHG3JQlOmXjnnJA6Z/u/Gqnq/2dgnxPiFoQt02ZpfkR6g8/wxr7M020K09MBIAU/0Uww3Ngzr2/HZEuP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721575; c=relaxed/simple;
	bh=K56mKHHLXtwc5hRAfxeaXBiGz2WSxbaQnlx7RfbDe5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv+wC+xFpY5FpydoxTI05HBIYfb34YohJQd0SQeW3mE/sKUVfpZt7oHxEe3hL8rY5Oe4QAzxo0uyWYLKv6lKTa1aJkxhF4PPLKhRG2ws7uC/Gyr2rKJUfQPkso0TgvMzhw5Jlu06Uv/c4iIy+lwoKZyyOD6l9QPG2X5MNdWv6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=itLrDnJ8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d20451c016so313289885a.1
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 16:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1750721571; x=1751326371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oTfT9g5hWGgx6r00qx14KfZ3qfGiluwHm7OsvjyNUSw=;
        b=itLrDnJ8rjpK8rFalvkyiWAFSw+Leg04SsKcSlSWPHDUxsPiyLvM69wOzq5vvvLnMY
         hCQ4/xh+zl419aG5OV6Pz5w1/oTAe3Juw1xkk0r+SVMVedKNfQRIp5qoiSP0I7OiGDrV
         3TZ3hRG5LonfPNO/YmVB+63qOXnWanMOkevxDtpzGM3zqtjy6IoeQbSQF36hCSOb8rVc
         DAhsFDRVtNDT5uByqyiLB7TCrWzbvFhv5mjCLjkjA/JzX6NvBPUqOpVlunIguBMmhSNC
         rBtx+x2KoN72C9WP7UE/Zpc1+UWY6rZGIniNtiJX6aI66Rl2HgpBcj8cNUta/peSPyLA
         KP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750721571; x=1751326371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTfT9g5hWGgx6r00qx14KfZ3qfGiluwHm7OsvjyNUSw=;
        b=TPc28F2HBLsrw7FKXY8MfJQiQlIEOZmrl+SiBpvsfoulxY64zKbpZerbWSYVrLN0of
         gCcuGUf2z/AGchIcHzaaGxDyVLCMFRkhhRC42kRikRwIqgjs9mX0DlNT6NcC2l5gqRia
         j5Yh8hbDywpqk5+sQK/fCIJKUNtE2CGbO5RzHCC1A+rcg3DZSaTA0a0e65QaPqZE9pnu
         iXf8V+PztEOgcmBkVsZow/JuiTb38eqNIpfNEL/4glzuFoRNRPIzQFEP6s0Q5LWEeH5X
         3DaUZBknQ/2Dp01jFw7co3/H8xeTX73DIvLBm7uiRbv050lCd0bSMpHobhvf6Xd0mcKY
         mmrg==
X-Forwarded-Encrypted: i=1; AJvYcCU443DwPLhXuftI2jsqsXzb2S5T6hGbqn/Iggg23jQYJRtR3dB0f2odFTid6HNq3CyLczUe2DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfnd+P02RRwBict3qHXcpDT6HJt0TylObOI8Hxvt617ZQfH2UI
	6aXPLDTRma4MrvC44Q3AeazO5Ms7xk8m7OAQwR8WM9VAb3ITX8aO4hO5KBs2z0o89A==
X-Gm-Gg: ASbGnctq9vg7IODCVJkSuM93TrQPMgJHMBc618OcMzz5w7k3yM6N/YZlTNe02I3y+s9
	74cGRfmXW4uYkl775n+DP9kbn2mInz9+RnplQlnFmgLu6oPDWlXrmJP+5SXr9t8rmFN+oYdgVWS
	aqXmUbXbCh0Fr+4tDBle+mz1+WqweDxoVpvVieurRBmVpuOA85Jkj6OtXXTnMTpCH/KNfkF/Fxx
	FSLllqBuk6r5giP/cuz41dVu9z2AWY9xbOSnL8OBnOPdPpVvX2MkTlT7pCk5qU0X++jpzVR4UQs
	ceKCwH4vbJfH9Uwn1694qpPSj5dhWhfQ+2yAz5/BAHgD8A83doml6n9tvHeRrxe3YxTeo9Qdix+
	iWtMy0LriKxNzI5HUb1ReNffuBBH1PTA5q40=
X-Google-Smtp-Source: AGHT+IH2Hxbk32TYcAMEqNHRkSeOyH3MAsgPDvjbRbtpcnyPxJE9w2Xitm1Hj7TqVWBLzq3i9t3oHg==
X-Received: by 2002:a05:620a:2692:b0:7cd:90eb:7d70 with SMTP id af79cd13be357-7d3f991d078mr2058472785a.35.1750721571218;
        Mon, 23 Jun 2025 16:32:51 -0700 (PDT)
Received: from rowland.harvard.edu (ool-4352cc89.dyn.optonline.net. [67.82.204.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99f0351sm443924585a.70.2025.06.23.16.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 16:32:50 -0700 (PDT)
Date: Mon, 23 Jun 2025 19:32:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	oneukum@suse.com, stable@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH v2] usb: hub: fix detection of high tier USB3 devices
 behind suspended hubs
Message-ID: <c73fbead-66d7-497a-8fa1-75ea4761090a@rowland.harvard.edu>
References: <20250611112441.2267883-1-mathias.nyman@linux.intel.com>
 <acaaa928-832c-48ca-b0ea-d202d5cd3d6c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acaaa928-832c-48ca-b0ea-d202d5cd3d6c@oss.qualcomm.com>

On Mon, Jun 23, 2025 at 10:31:17PM +0200, Konrad Dybcio wrote:
> On 6/11/25 1:24 PM, Mathias Nyman wrote:
> > USB3 devices connected behind several external suspended hubs may not
> > be detected when plugged in due to aggressive hub runtime pm suspend.
> > 
> > The hub driver immediately runtime-suspends hubs if there are no
> > active children or port activity.
> > 
> > There is a delay between the wake signal causing hub resume, and driver
> > visible port activity on the hub downstream facing ports.
> > Most of the LFPS handshake, resume signaling and link training done
> > on the downstream ports is not visible to the hub driver until completed,
> > when device then will appear fully enabled and running on the port.
> > 
> > This delay between wake signal and detectable port change is even more
> > significant with chained suspended hubs where the wake signal will
> > propagate upstream first. Suspended hubs will only start resuming
> > downstream ports after upstream facing port resumes.
> > 
> > The hub driver may resume a USB3 hub, read status of all ports, not
> > yet see any activity, and runtime suspend back the hub before any
> > port activity is visible.
> > 
> > This exact case was seen when conncting USB3 devices to a suspended
> > Thunderbolt dock.
> > 
> > USB3 specification defines a 100ms tU3WakeupRetryDelay, indicating
> > USB3 devices expect to be resumed within 100ms after signaling wake.
> > if not then device will resend the wake signal.
> > 
> > Give the USB3 hubs twice this time (200ms) to detect any port
> > changes after resume, before allowing hub to runtime suspend again.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 2839f5bcfcfc ("USB: Turn on auto-suspend for USB 3.0 hubs.")
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > ---
> Hi, this patch seems to cause the following splat on QC
> SC8280XP CRD board when resuming the system:
> 
> [root@sc8280xp-crd ~]# ./suspend_test.sh 
> [   37.887029] PM: suspend entry (s2idle)
> [   37.903850] Filesystems sync: 0.012 seconds
> [   37.915071] Freezing user space processes
> [   37.920925] Freezing user space processes completed (elapsed 0.001 seconds)
I don't know what could be causing this problem.

However, Mathias, I did notice a minor error in the patch when I read it 
again.  It's in the new part of hub_activate() which does this:

+		queue_delayed_work(system_power_efficient_wq, &hub->init_work,
+				   msecs_to_jiffies(USB_SS_PORT_U0_WAKE_TIME));
+		usb_autopm_get_interface_no_resume(
+			to_usb_interface(hub->intfdev));

Once queue_delayed_work() has been called, it's possible that the work 
routine will run before the usb_autopm_get_interface_no_resume() call 
gets executed.  These two calls should be made in the opposite order.

Alan Stern

