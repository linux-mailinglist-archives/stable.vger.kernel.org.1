Return-Path: <stable+bounces-62812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D603E94138F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EE81F222E2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB291A08B2;
	Tue, 30 Jul 2024 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rsqG/cve"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BDF1A073B;
	Tue, 30 Jul 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347346; cv=none; b=PuwV3YfHvkGf+WRFYLvVwBtSEuwh2jm0DeU+nZO/TM79HUOHE9AajPh7cdQDvLK/COMks0r1AIEo1WqWBStiQM/IbouVRi2QXgiUREDJx+I39awzCvE0d1lLVrZ82eIq4SXYeoaztSdvoKvSUGrOaccPsM/AGGZ1+FpLcFzfvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347346; c=relaxed/simple;
	bh=iYAdo2UpfsskK1cDpNe8jKMpWu9xwT+iyf3uHSZX8vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnKzwBSk78sTlXMemh/t2mqeFa4QgWnP1EQlTlUqRNz65cuG/o9asSCV2tgEc5eN1lYB1f0CX379wj9NEDC/U4yRVCimK0U1w2SMbxRbTMF7+4E7q1DOKfkZAcFMnrClCeZf9u29RqL/mykhF89eUrVKy84un4XExk5n9l2isiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rsqG/cve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18785C32782;
	Tue, 30 Jul 2024 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347345;
	bh=iYAdo2UpfsskK1cDpNe8jKMpWu9xwT+iyf3uHSZX8vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsqG/cveCG2wG6SYBcHtlgJBTzwEwscMkSDm+5Rjxdt3pzHTxHeQak/NlcoFlBUXT
	 4QnWmZL7WXQF7DqGZtWF4c3l7ClexDeapdU4efZJAH19drKBS/JiEDH0WPQDbrMpPz
	 +4zH3x/Xvn8UeqExAnibRmU1+TPxMfQSugwsuEQg=
Date: Tue, 30 Jul 2024 15:49:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Erpeng Xu <xuerpeng@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, hildawu@realtek.com,
	wangyuli@uniontech.com, jagan@edgeble.ai, marcel@holtmann.org,
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
	luiz.von.dentz@intel.com
Subject: Re: [PATCH 6.6 3/3] Bluetooth: btusb: Add Realtek RTL8852BE support
 ID 0x13d3:0x3591
Message-ID: <2024073057-quarters-unwanted-edf3@gregkh>
References: <20240729032444.15274-1-xuerpeng@uniontech.com>
 <A8A861A3B03BA706+20240729032444.15274-3-xuerpeng@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8A861A3B03BA706+20240729032444.15274-3-xuerpeng@uniontech.com>

On Mon, Jul 29, 2024 at 11:22:54AM +0800, Erpeng Xu wrote:
> From: WangYuli <wangyuli@uniontech.com>
> 
> commit 39467e918e512d6907689dae0e4f035cccc10ab4 upstream

Not a valid git id :(

