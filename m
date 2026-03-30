Return-Path: <stable+bounces-231243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HENN5SPymn09gUAu9opvQ
	(envelope-from <stable+bounces-231243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:58:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667635D4E5
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C33773075D57
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5A3264CD;
	Mon, 30 Mar 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="UT325jDN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C02E091B
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882197; cv=none; b=sxfOuEhYhvTXnu1b8GyyfiMzSBxSuJDT53bXwkH0QvByAXCdwH9t2d3wOT1sOedjyUw7rL8rj+axRDmdL1CgIaP/j2nyjojNT88O3r2mSxSNvPjf8sVLy4cwecHG9sHy+8HZbI5zCnXGRktSptVAg9TMQmc064Nx/eU/RkcAdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882197; c=relaxed/simple;
	bh=r74CxeVQS+MaGx5qIStVX7Dkyw5eva6XeRU/qgsTVAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn1womVE1JxiEEtrxgmlqSXsJyR8bcfcUVO2W7ojqzhgKDvapjoP9JI8FUeTrRFDfwWTd0a2BjZWwyCArbwQnLlZ6gr4Pb//MDbqhJfk0HB406aN+paJSK0kgR6Hp0VqfMc5iaXAUKQBbWQLW/sX4RowvKPAwxYDk0wwif6+nKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=UT325jDN; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50baafd6c4aso31330821cf.1
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1774882194; x=1775486994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d63VizpxJtFsSbrbeZx9OSixUi8R0KJ6qBhGjjaILvs=;
        b=UT325jDNS4v2GildsP7RhA6j0QOPtyvGvrWchyDKsd+UkRQKj9ciPI3mHcyIVq27Nk
         DJMk2nGYg3zklKxt9JKmNXOpivT+6gb/w1CCxktvd6aJ8QlS9MhBJ3oVxp+UbV+k+dxB
         Hl9fZDw1CMR4ihE9OluRXDmp/K/vL7aj7yYr0pJ+J58Zk/wCI00TC8bQytMLtVUGfrEv
         A9bT4NHzi5w+KViuV/iFHgWxwxm9J1ojc0Sj0pdJ+qybsaSG1ycL9c+WMi4YxchpXmZo
         3CoTx9ycLfEJgl431svLXZQ/tdt4PpajFN2E64iH0P/EmulQM6kdvvdCi9zoB28JvhyH
         A8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882194; x=1775486994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d63VizpxJtFsSbrbeZx9OSixUi8R0KJ6qBhGjjaILvs=;
        b=QSjkzjXkRbRS74dmPZih3M1rw7v2t+zV3Y70g5ouz9XhjlYy9tl7Az9COWUFvfnwOw
         B12rGSoHLJ0C/ZTpdTxjlBtH1t7PSILqDDyBew+1vocm9a+7BAbU4M9TsGXo6aeWgAwv
         FdFtXHmMtRN3m9cVQ6HmZaQxGKIsXUBFrE2JUhybzrRNF/xk3eYn/BSgw5H9GU3kLYSC
         Y+ggIJye4IabTLToY2S4Wwm/WzxO+OBD0mg8606ailad4JDOd2tA3LZXhJDuFIYZhaPQ
         jL0BU/ues7F0fxpbMZR4n+EmZ6AYw7Rcm/4Ed8m06NB3v0nRFQzBjZbhNxYcX+mcdImT
         OLJA==
X-Forwarded-Encrypted: i=1; AJvYcCURO8KIqsdSRzDQ/gqZXHwSXaU2UnzDeFnne09+YKtCPFducr+jjITw8Q2ZRBiRLCHYgcp6j9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2I1BeGZlQt2Lca6SJxoY8WrUX5H04YbJvlAK1ATw+zI+0wkZB
	5105pADxgfu13m161Uu2f3pfmfmt5Q0dN3myBhaAQzLLY7CXiGjm4lvDCBihx/4bsA==
X-Gm-Gg: ATEYQzwiRYQ4ArtVTD+Ut1cujbMo/7dVpVd/p41Jl7IsZvTDJeUFOayERgACNUVuaad
	6mAdeFcYTvY7nvbcPDh43bsPER2mk6wTkHAm/fH3caRE0seXrB6rkO+RKB8xo+dQtIzn23RPT+b
	sbLXzHoCThnhS549Npo0wX7fgRRYNAo1CMnCKIhEaACVPr+/qNXcuWVXotDcuCaL77k4nRJesFW
	epaZgawTd2E7uMxRAWo1DIRjSi2CQtbwLpTcU1RFTQCqyaodSa/4JEE3uFme/FZs1LEj+HkzmAl
	11jVmI3PdqQSzd5jze1Ap0DLEOJgPglpV9IkzWtxufmNATBdxdXkH2TSRr7urTSGypXikVfEL8B
	9PPZNCdtcxIQxWwWFTD+2b04zzw4vpP5NuCzQ61splTv6E3rO8oVYy3JVgzmKGV/1D1FM/fKRTl
	0MsHGe1ZR/7xPSyJ15MZWDXIKCM6lmpf6sPnwLni+7mg==
X-Received: by 2002:a05:622a:1343:b0:50b:404a:746f with SMTP id d75a77b69052e-50ba3976e93mr171565381cf.58.1774882194276;
        Mon, 30 Mar 2026 07:49:54 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2c67fefsm63548861cf.4.2026.03.30.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:49:53 -0700 (PDT)
Date: Mon, 30 Mar 2026 10:49:51 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Saravana Kannan <saravanak@kernel.org>, stable@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Don't let a device probe until it's ready
Message-ID: <55bd10b4-4d4f-438d-9f15-9293bbe3c734@rowland.harvard.edu>
References: <20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330072839.v2.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231243-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email,android.com:url,harvard.edu:email]
X-Rspamd-Queue-Id: 3667635D4E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:28:41AM -0700, Douglas Anderson wrote:
> The moment we link a "struct device" into the list of devices for the
> bus, it's possible probe can happen. This is because another thread
> can load the driver at any time and that can cause the device to
> probe. This has been seen in practice with a stack crawl that looks
> like this [1]:
> 
>   really_probe()
>   __driver_probe_device()
>   driver_probe_device()
>   __driver_attach()
>   bus_for_each_dev()
>   driver_attach()
>   bus_add_driver()
>   driver_register()
>   __platform_driver_register()
>   init_module() [some module]
>   do_one_initcall()
>   do_init_module()
>   load_module()
>   __arm64_sys_finit_module()
>   invoke_syscall()
> 
> As a result of the above, it was seen that device_links_driver_bound()
> could be called for the device before "dev->fwnode->dev" was
> assigned. This prevented __fw_devlink_pickup_dangling_consumers() from
> being called which meant that other devices waiting on our driver's
> sub-nodes were stuck deferring forever.
> 
> It's believed that this problem is showing up suddenly for two
> reasons:
> 1. Android has recently (last ~1 year) implemented an optimization to
>    the order it loads modules [2]. When devices opt-in to this faster
>    loading, modules are loaded one-after-the-other very quickly. This
>    is unlike how other distributions do it. The reproduction of this
>    problem has only been seen on devices that opt-in to Android's
>    "parallel module loading".
> 2. Android devices typically opt-in to fw_devlink, and the most
>    noticeable issue is the NULL "dev->fwnode->dev" in
>    device_links_driver_bound(). fw_devlink is somewhat new code and
>    also not in use by all Linux devices.
> 
> Even though the specific symptom where "dev->fwnode->dev" wasn't
> assigned could be fixed by moving that assignment higher in
> device_add(), other parts of device_add() (like the call to
> device_pm_add()) are also important to run before probe. Only moving
> the "dev->fwnode->dev" assignment would likely fix the current
> symptoms but lead to difficult-to-debug problems in the future.
> 
> Fix the problem by preventing probe until device_add() has run far
> enough that the device is ready to probe. If somehow we end up trying
> to probe before we're allowed, __driver_probe_device() will return
> -EPROBE_DEFER which will make certain the device is noticed.
> 
> In the race condition that was seen with Android's faster module
> loading, we will temporarily add the device to the deferred list and
> then take it off immediately when device_add() probes the device.
> 
> [1] Captured on a machine running a downstream 6.6 kernel
> [2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libmodprobe/libmodprobe.cpp?q=LoadModulesParallel
> 
> Cc: stable@vger.kernel.org
> Fixes: 2023c610dc54 ("Driver core: add new device to bus's list before probing")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

