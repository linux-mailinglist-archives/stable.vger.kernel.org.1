Return-Path: <stable+bounces-23471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5586126D
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 14:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C65AB23E21
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5177E796;
	Fri, 23 Feb 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fY7JJSmi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090667E777;
	Fri, 23 Feb 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694134; cv=none; b=qSaDmEk8rq1qdhNVLt/0Llye1l6cSIYOw2SuYQRj/PmnfLbrb7g4tfjEhzUlCxBtscsXygIJ9oLT9QUj4q9AjXMC/wJqWk56CKAJYZgh+ymn2N/RZvbokAiDqn41gVUliLQpBcaFkjuuBwXAb/4Xyqh8GfH7ZtqZMh8Odac63uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694134; c=relaxed/simple;
	bh=QEmz+DEv+wYIwWLTLObUJu7Rgtz4EV1cC1KA2e2teE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuVZ/G7bWnh7G6C7eFLDqDbcznBsWKEbUVVL6Qr1EuabLYrevLQEFGC3ipd5mfOy0PDm8gV4iOtINRc29uTyxR90v2ZETDMCyx+KnnV1dEHRA60RD4cO/5VPwfj/IWxgFcLPF0BOL5FW1f/9wd2c+lPVijl9BKTiGiXmcVNZ0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fY7JJSmi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F83CC433C7;
	Fri, 23 Feb 2024 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708694133;
	bh=QEmz+DEv+wYIwWLTLObUJu7Rgtz4EV1cC1KA2e2teE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fY7JJSmiDJVIRS38KIdsUCjU0Vlcrpci4di1jK8PLA3Mp0KTKe9mjuhFT1TsiQAB1
	 YZe3Z6xb6yD33rnKVq1O7gyu1GTdo32LkquM6jGUJiwt2NzrK3/upjsxZI4sHsI/BO
	 0nzfBL7ZXEUNrKoa4/dwZTt8JFOocw/ZJLWgsb0A=
Date: Fri, 23 Feb 2024 14:15:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, joel@joelfernandes.org, chenzhongjin@huawei.com,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] linux-4.19/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
Message-ID: <2024022323-profile-dreaded-3ac7@gregkh>
References: <20240207110846.25168-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207110846.25168-1-qiang.zhang1211@gmail.com>

On Wed, Feb 07, 2024 at 07:08:46PM +0800, Zqiang wrote:
> From: Paul E. McKenney <paulmck@kernel.org>
> 
> commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.

Again, not a valid commit id :(


