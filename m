Return-Path: <stable+bounces-86839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF609A4123
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 16:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3434B220B8
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84DE1D7989;
	Fri, 18 Oct 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1JVKcgf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A7188A3A
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261675; cv=none; b=ETaNpjRqVqDJ03bxK3QgtTswnNpKedCH+CMH1nEJ4w5aLz8+yHam/ZTAmQLDK5sh0ZFm3m3HYrIhUKMTUPYo9eCWnCuM4xjz8+w32tw1YmRNqoWykmpwHAKtIitHt/DlpddgND95zaLBuIojNm9hhKJ0H3iyXxYQmhm73l9z9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261675; c=relaxed/simple;
	bh=Ng6Hi748YUobwzWJ1Hu8NtDzUdPlYfgUuf0Mv78ybMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbhgcIda8CQmmwtxLHwvl80cIC7ieeztLSlb/WOWVM5MqCzYsfkww8T/BvPohsDiQJn+0fOOSxP9LapHfdVP7g7UukrlpCMTi6H6dWc+Mbr8quHHKiiovYGLW0qn2cjUp5RRufXWzn0b7MJ+wvzDfP8nK5OkFqjn3UqXvpmQR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1JVKcgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8303C4CEC3;
	Fri, 18 Oct 2024 14:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729261675;
	bh=Ng6Hi748YUobwzWJ1Hu8NtDzUdPlYfgUuf0Mv78ybMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1JVKcgfRB4regIlYQmxrsbcflL7rE7v9xIRr5c0QD53/09t0ZaMOVDStwp6OB2uI
	 J/kdwjqiazn/enX/MD2OBdKgEuaZ42rFyQqKyvw/BeyFfvD4koMxYwayTo71gf2CYO
	 OZ3hTA8IIc+tuPAcxymDaAM8U4EjFSplmTS6ocSk=
Date: Fri, 18 Oct 2024 16:27:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Zhe <zhe.he@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10] ftrace: Fix possible use-after-free issue in
 ftrace_location()
Message-ID: <2024101835-facecloth-yiddish-dbbb@gregkh>
References: <20241018135428.1422904-1-zhe.he@windriver.com>
 <20241018135428.1422904-3-zhe.he@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018135428.1422904-3-zhe.he@windriver.com>

On Fri, Oct 18, 2024 at 09:54:26PM +0800, He Zhe wrote:
> From: Zheng Yejian <zhengyejian1@huawei.com>
> 
> commit e60b613df8b6253def41215402f72986fee3fc8d upstream.

This is already in the 5.15.227 release, why do you want it applied
again?


