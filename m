Return-Path: <stable+bounces-110135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E50A18E9F
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 10:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C30E16B94F
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A51F75B2;
	Wed, 22 Jan 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4UsPfRc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D625C1AF0A6;
	Wed, 22 Jan 2025 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737539191; cv=none; b=h4UgHZyBrTSKkqKXH8K1DhzX79EZ5AeHxKbvJ/bXfXrQFJnqmr1vWWeXqVMmxnbRwoPn8kac8KX7AfA5k9voowyEB+0YcROWjpkaIHydP4Iz/kM4dWLvDAPlHekLt5iYmYjejMEK1zY7zMeTRyBDoDEmiMytSOvQRtGyjqaJKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737539191; c=relaxed/simple;
	bh=ACFxprAxQ1Ik8g0Ws8+ikwFrYo341kDbtX7wZXRuBl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIHambezlvrBSvP8csZtg7Q8plCjPAYoNktilInEotJRa4mE9XKKrAzGrZ0AtHGjnDle2/NNotiCDwGP6tc4yp0LASRiaHENv75lsPFOAhFOkvH1w+epVrYgzhzKbAn3JC8+5bOdWJGnw73v4qZQBoUzrM+wgQ4Dmiace1tJdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4UsPfRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579C0C4CED6;
	Wed, 22 Jan 2025 09:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737539190;
	bh=ACFxprAxQ1Ik8g0Ws8+ikwFrYo341kDbtX7wZXRuBl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4UsPfRcWvcSEjT5DnxxGYnXrkiVnHdw27FujJvPuIl9UaChQhFD9OXSRfEdKNjU9
	 WwrtWqHDz4ATeBf0KJrXtIYUz32jMNamz+PAW1uW+F5X4wEpUQeLBduQnTBaryjNbS
	 eWmEVFiJ2O5NZXbfqdYeBkChPQNjLUp3ITVz+yoSHort+GfPTri1XJsefAr4tq+xjT
	 D4EpE/M6Kb6iYDpkFDKc4RMLu48zulC0GKCqG54b7cDNeOzd6ShaU69eP2PmijXFku
	 njdlnwpka/GGrKuKkXHdrIYQix9HcL9PLMEn+NvuUS7Axeg8eruA0OCwHp5gp89FRB
	 CFWqYuHrH9IRg==
Date: Wed, 22 Jan 2025 09:46:25 +0000
From: Simon Horman <horms@kernel.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, kuba@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] atm/fore200e: Fix possible data race in
 fore200e_open()
Message-ID: <20250122094625.GA385045@kernel.org>
References: <20250122023745.584995-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122023745.584995-1-2045gemini@gmail.com>

On Wed, Jan 22, 2025 at 02:37:45AM +0000, Gui-Dong Han wrote:
> Protect access to fore200e->available_cell_rate with rate_mtx lock to
> prevent potential data race.
> 
> In this case, since the update depends on a prior read, a data race
> could lead to a wrong fore200e.available_cell_rate value.
> 
> The field fore200e.available_cell_rate is generally protected by the lock
> fore200e.rate_mtx when accessed. In all other read and write cases, this
> field is consistently protected by the lock, except for this case and
> during initialization.
> 
> This potential bug was detected by our experimental static analysis tool,
> which analyzes locking APIs and paired functions to identify data races
> and atomicity violations.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
> v2:
> * Added a description of the data race hazard in fore200e_open(), as
> suggested by Jakub Kicinski and Simon Horman.

Reviewed-by: Simon Horman <horms@kernel.org>


