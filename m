Return-Path: <stable+bounces-81473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6681993689
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 20:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1DA1F23070
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A41DE3B2;
	Mon,  7 Oct 2024 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4Jx7ym0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51C31DE2B9;
	Mon,  7 Oct 2024 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326752; cv=none; b=pT0FFhCAz832lL6jsgwMirC9v70XLR9tFfnnyqAH9zGeyFeAUyfbWWNPnM6GcGe0tE0gaGSeYuPdPA9PEPBw60zOaqzcvXR5lcmIl/geChbAh0BRM/jjpdOS3DNv1JJCedY2LZDtQDBvSrkTR06R8n/S/V6c82sG2p4Rk6pajt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326752; c=relaxed/simple;
	bh=6HDHCFaACQLMKlKfLuD5oVPiDJzlRALF5s4/S2q6XNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7FTWK4Gg3qjoJWpHmMjPPQz2KhikMGaIQT4xZUpqK007CPh4Swh/OoiEumK+kCnPQtSOyr3gw20C7agoBgXjW+tCbpcfa4UdoMqjdoMf+/Ih9VoOS6TwTl3VvoWoxLXlc/Fjn2PvTiFzpQiamRoUWEhP26ISP459H/sEx/39yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4Jx7ym0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0D2C4CEC6;
	Mon,  7 Oct 2024 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728326752;
	bh=6HDHCFaACQLMKlKfLuD5oVPiDJzlRALF5s4/S2q6XNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4Jx7ym0k6c8wzRoBZ9T9dmI3Qvpyh3uOAAGr/hPHqpwrrpiPrugPpuYTOBCRfEov
	 cn/p1r0KJR6KlY8f6Sp/oSK7ftNlNzVBgFQ+cYvGjlo5yl609Tt58Dhl3Coe4cv4MB
	 1XNHNTReNwEYdvntltWfTF9vhO4IJ3vcUT3jBDv3blFEv58qBLphbSTUeS448YOF8J
	 UcVob0DNJhS1bYEMSbFpFQnDzn4Fs1+HmO4yBjqsu/UpXBUkPCHMb23hmj0s40kUCN
	 SLsDXo75zOiCVX4h6CC8nCrWXbKxnABiaeQCEIXBBV5ZkxvhgHjcMlQrD7vCnr9X92
	 R7Wwyvmc+Wrvg==
Date: Mon, 7 Oct 2024 14:45:51 -0400
From: Sasha Levin <sashal@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: Patch "coredump: Standartize and fix logging" has been added to
 the 6.10-stable tree
Message-ID: <ZwQsX9pMUXKEOlsj@sashalap>
References: <20241006152737.10366-1-sashal@kernel.org>
 <b11f4672-6c68-41f2-92c3-e7a15555a6ac@linux.microsoft.com>
 <6144d8b5-8b3d-42d9-bf28-b88327f29124@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6144d8b5-8b3d-42d9-bf28-b88327f29124@linux.microsoft.com>

On Mon, Oct 07, 2024 at 10:36:56AM -0700, Roman Kisel wrote:
>Adding also Oleg as it was my impression from working with Oleg,
>this area might be of interest for Oleg. I've crossed paths with
>very few people who contribute to the "./kernel", and don't know
>who to ask for another look if this is safe for the stable kernel.
>
>Let us err on the side of caution perhaps unless folks are sure
>all is going to be well with the stable kernel and get_task_comm().
>Another datapoint would be that Linus reverted this change from
>6.12-rc1.

Let's play it safe and drop them. Thanks for the report!

-- 
Thanks,
Sasha

