Return-Path: <stable+bounces-116794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF8EA3A099
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4581E188B297
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913C26A1B9;
	Tue, 18 Feb 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0eTyGfcF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE526A0D2
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890659; cv=none; b=TI+mnOwO5mDIJlNee5HrUkQauHJvOWwGVUoerubEAnN0auvx9mbEAkj3cbaQ0wZQC8s6YhefA8RMKOoIsMHddn1YDDBA2lhnVZMrzcWdy6no8AXPc+imSbuoTnimwHYYwK7MxciJ3UoP2Hyzf4z6KF3rlPZbCGc+PW5nQ5Ll+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890659; c=relaxed/simple;
	bh=fpR6bPo1pV8flGeKTnVmJZcK9mlRlCc51rzXem49Nvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8qpi/aWQ9NrCgFssjLu2FrCXI/IktFEQOdM+9hJfFyHfEd2SS5LeB0MK82MUJTUNKWeEcLsu0REwE9+xYfDk7EKbtvjn/0ef3o5TzBZ3/hctRFbQ8wPe5MSZ+2Yp/Ez7ssnz7ISAa7Y3MOg+rGeb9SrHLanH7YZkoHMJJuoW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0eTyGfcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279ABC4CEE2;
	Tue, 18 Feb 2025 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739890658;
	bh=fpR6bPo1pV8flGeKTnVmJZcK9mlRlCc51rzXem49Nvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0eTyGfcFcEuaidnJnjlp9YCyh/UO+mlPt4Nn6QkORgo+ZVL56IV7EXZ6p+7coNhLt
	 6d4niIl9eFNxk/TCOUD8LUC3W7Fd5IiMd+OH62/2jc/t86T4fHPrYPHAkrjd1/gP8r
	 LSE/N9yqSqa4ScC9JTxc+Fv9zDqv3uinsoyBFNuU=
Date: Tue, 18 Feb 2025 15:57:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: stable@vger.kernel.org
Subject: Re: 6.12.y stable backport request for bpf selftests fixes
Message-ID: <2025021828-imposing-job-bf1a@gregkh>
References: <72bd9b02-ba1c-41d5-878c-331f0b93bf28@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72bd9b02-ba1c-41d5-878c-331f0b93bf28@oracle.com>

On Thu, Feb 13, 2025 at 09:47:10PM +0000, Alan Maguire wrote:
> Please backport
> 
> 42602e3a06f8e5b9a059344e305c9bee2dcc87c8
> bpf: handle implicit declaration of function gettid in bpf_iter.c
> 
> and
> 
> 4b7c05598a644782b8451e415bb56f31e5c9d3ee
> selftests/bpf: Fix uprobe consumer test
> 
> to 6.12.y to fix BPF selftest-related issues (compilation failure and
> test failure respectively). Both apply to linux-6.12.y cleanly.

All now queued up, thanks.

greg k-h

