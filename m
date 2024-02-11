Return-Path: <stable+bounces-19449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13847850C5C
	for <lists+stable@lfdr.de>; Mon, 12 Feb 2024 00:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9192A1F21D5E
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 23:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A5C171A5;
	Sun, 11 Feb 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8xCJj+p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E941EEB4
	for <stable@vger.kernel.org>; Sun, 11 Feb 2024 23:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707695075; cv=none; b=pitqsY35gLBlDoSBPTOq6YAHUdLFMCZ+o+gAbCEgA6sL3kgXbezO1vM09w3DdXasdqJ6CKYWnuzp5CQER/hPyajr7WDOnPaVgeGdCc3QQuLhW//aaIt4zbupd40+SP2hye3wL9fB5vspqa6JMbjUk7ZoO/5VfkQ23ryKueM1Q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707695075; c=relaxed/simple;
	bh=UpnTI0fv7WUCUQD766poA6+obRM4m6qldDoX6uEsvnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYqv8a5Ic+bO0Np/RILZtZnXVH7Z/E7GNk2Wv0k+MxfdN9cIBm5DGw4gJsAhKTpxjqz9v15asHCCu0NaQe56SRz+zFLaNtwbUzI+LRn746VDlHKSC/5aa6yR6tqOsI6h4F6R+TyosmBz7OUPM7aal+9BYzPnEaxv2L3b1W0au2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8xCJj+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BD9C433C7;
	Sun, 11 Feb 2024 23:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707695075;
	bh=UpnTI0fv7WUCUQD766poA6+obRM4m6qldDoX6uEsvnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8xCJj+plbceUxvr6T4A4uuTMfPdqFtSMZpHpylmOc4W1D8yfu0Ct4TWSrXhumq4w
	 yzvReffn7AQx0AQBFfIRDBYLv8t2zzUdwgdeTxBT4ZtIwRun/uxV1nS76RkPDcklJA
	 FDYjvsPDF5vhMgrvV3yw6VmxFSddz5Yrd+Vo6ymCwQjipOp4vLIaza+zYkCK71Ipd7
	 ERoT/jbutENXM3DXD2pQKg1g8fdJ58jmch2NHLSD2201nk3OgfqrD7nHaIt4UGKZk7
	 HP6ui9X+5INLB6iQ77B0eeSCOmlpREqO8Zs2C0UaHWUgGH8nBmSmSeq8oovvdv2XmO
	 0eu1JkIn08taw==
Date: Sun, 11 Feb 2024 18:44:32 -0500
From: Sasha Levin <sashal@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Please apply commit b4909252da9b ("drivers: lkdtm: fix clang
 -Wformat warning") to v5.15.y
Message-ID: <Zclb4MjULhQLeTZS@sashalap>
References: <b87dd10b-b8d9-417d-bea5-db5a5fc7d86a@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b87dd10b-b8d9-417d-bea5-db5a5fc7d86a@roeck-us.net>

On Tue, Feb 06, 2024 at 10:58:05PM -0800, Guenter Roeck wrote:
>Hi,
>
>please consider applying the following patch to v5.15.y to fix
>a build error seen with various test builds (m68k:allmodconfig,
>powerpc:allmodconfig, powerpc:ppc32_allmodconfig, and
>xtensa:allmodconfig).
>
>b4909252da9b ("drivers: lkdtm: fix clang -Wformat warning")

I'll queue it up, thanks!

-- 
Thanks,
Sasha

