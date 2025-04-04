Return-Path: <stable+bounces-128278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3295CA7B7CC
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 08:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B112A177CFB
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 06:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B018BC3F;
	Fri,  4 Apr 2025 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EdBbSfqx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAA18BBB9
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743748181; cv=none; b=biZdd31Y+Q58dEdrmclm9FpaHBNf5b9x7Vy0Q0wjnSDa8Ufxj0EPIrDlbWvUiXGunBmyA3w+IQcsb7am6+OeZRJQpYD5hUIrTQGofiXtqW+mXZle8ugPQrRXC9fNNWSYGRTzs7QPASVdkP7/da9W3tk9YGuwtPRzkl1nNkjQh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743748181; c=relaxed/simple;
	bh=feOoLpQa/cJAk+pk/sonn+0c4v3wNV8n3E+WLUjvy6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzYvO20yslwxA/BdoOD5JabQQIbGJHI+RwV09yWbZ4+m3Skoa6UgUAu0lnOQcwuQNeYiEpsgrvjG3A4Q+M2oz6bJWGG+lrSLJnRA4n1dQO1otZVXs3kNdJjed65scpj2RIlB3Y/fhn3hkrkx/fG1mTZ2VkbAGw9txv3ZzTjQJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EdBbSfqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C955C4CEE5;
	Fri,  4 Apr 2025 06:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743748179;
	bh=feOoLpQa/cJAk+pk/sonn+0c4v3wNV8n3E+WLUjvy6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdBbSfqx17cVOH96F6yPfvNhLgX2Lcrgx5NoMQWSbE5RADONGY2j4+/qUYzfN83qf
	 ejVc3PV+yFHspdRKSR03FSsskk0UqOjrpobOsh0kSwPfVcHiW+rVS4HihL+msJINKE
	 qOi6sb/dNhWBMsfxcb03abe61TDL6IO+E+j/ZZnM=
Date: Fri, 4 Apr 2025 07:28:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Justin Tee <justin.tee@broadcom.com>
Cc: Justin Tee <justintee8345@gmail.com>,
	Bin Lan <bin.lan.cn@windriver.com>, stable@vger.kernel.org,
	bass@buaa.edu.cn, islituo@gmail.com, loberman@redhat.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 5.10.y] scsi: lpfc: Fix a possible data race in
 lpfc_unregister_fcf_rescan()
Message-ID: <2025040400-retool-spouse-0ecc@gregkh>
References: <20250403032915.443616-1-bin.lan.cn@windriver.com>
 <20250403032915.443616-2-bin.lan.cn@windriver.com>
 <d808abf5-a999-4821-a24a-388fee184ffc@windriver.com>
 <CAAmqgVM--YEC=hNt5H8DVUwvN9G5p=UX86X-VqKQG2wH9Re7+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmqgVM--YEC=hNt5H8DVUwvN9G5p=UX86X-VqKQG2wH9Re7+w@mail.gmail.com>

On Thu, Apr 03, 2025 at 01:58:00PM -0700, Justin Tee wrote:
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

Now deleted.

