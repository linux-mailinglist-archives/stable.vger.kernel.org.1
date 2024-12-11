Return-Path: <stable+bounces-100548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12339EC6B0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473F7167261
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D5F1CBE8C;
	Wed, 11 Dec 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eq3LNDvk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904A42A95
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904827; cv=none; b=aq6+7yZWT/7G6IMJ1gafOyJnT6V1LmdI6bqyoy8UpOzGtlx3n7jhU6ZHNoYBX/UgchW7J6T6MvxM5Y9DP1IlX5280afIa9tOzUAr537WKkeSZnwa47jrbv88BrAOvXCTMAOAY8VpiYYWJlhUILCay5sOAKmans8sBC/UUpFYseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904827; c=relaxed/simple;
	bh=vMPCy4RheVogI/+bo+fBZ5BTqj/yhFizjIlGxmz8+uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqbxNvGNdk+dGfGkZvgN1edW7SWP84ZipL7niYlBW5PgBLiUGUA4wLkaD3MqMFkZBeALhkZLxMtZ7wVDJRuTHln+OGlsgntDVq+WlM8qA67YLm4QTCuv+ZWv48IkjxqcmNQSMMMtpJtzMP3aABZDL+TA4PKjKNQ8CzemtHs85SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eq3LNDvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B291BC4CED2;
	Wed, 11 Dec 2024 08:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904827;
	bh=vMPCy4RheVogI/+bo+fBZ5BTqj/yhFizjIlGxmz8+uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eq3LNDvkKCnwy50X9Kg3MdatNSkcg+m1ZfsXqTSgI4oqkaEuIA9sY2Jf+L9307iJc
	 P6WVqwHHUpjyhVWGQRH0G7Vob+A/xga2yxJzzsUgkTiPQjHbPxdiai4I++yx83oAgU
	 wrTlFA/TpwIXCZqsZMqIlB4gI7uoGJxfa9nsUJHo=
Date: Wed, 11 Dec 2024 09:13:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: libo.chen.cn@windriver.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ima: Fix use-after-free on a dentry's dname.name
Message-ID: <2024121152-dispatch-cornflake-76ca@gregkh>
References: <2024061919-angelic-granny-6472@gregkh>
 <20241210020252.3221904-1-libo.chen.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210020252.3221904-1-libo.chen.cn@windriver.com>

On Tue, Dec 10, 2024 at 10:02:52AM +0800, libo.chen.cn@windriver.com wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> [ Upstream commit be84f32bb2c981ca670922e047cdde1488b233de ]

Please cc: all relevant people on backports.

