Return-Path: <stable+bounces-88036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09FD9AE49A
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D201B1C21C8C
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1175158858;
	Thu, 24 Oct 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLJVrAB8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932E1B6D17;
	Thu, 24 Oct 2024 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772187; cv=none; b=dVkzpT5sV86uOmnrJQ85o8qCM9L+ZngMWvUS0ecQBn9KrPu9PoLHOeF8qmyrJfpRNtDmZRKT029wTZV9eOWC7qAtDIZ5C5tXUDeRw8iFU7SgXU4c1nsXCX1WxgcEAoAwzxvY+pDVE2qQEluweK3OWzq58K12OHcQmJx07PCfKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772187; c=relaxed/simple;
	bh=W1U6tKaIXxeW1SqAj79tugQgcuGNB7svDxp/EzgYynQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIVOTvdEBv8jPuSvlEvtoXYgyVM3hqu/tzfJLfTkOS5py2PC5oLv4XDsYjLWNNL8e+rdvyQUqloGhreBTq3vHBjF8q6V/97ixaLy0GgqcbrlRG5wV1pk55oPDBGI+wxV6oW3EiBAqieTy+Gf827zXocHkIScqTcYuavVwtUfr7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLJVrAB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A827C4CEC7;
	Thu, 24 Oct 2024 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729772186;
	bh=W1U6tKaIXxeW1SqAj79tugQgcuGNB7svDxp/EzgYynQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLJVrAB89G7OnbBwp22VCwi0V5h6v2gJUGJ+G7p3aFjA9WAbiWeZkNS6Hih+QJMi/
	 1xOv/vGfKvJ93HBVQL+R8tZIUSMMVNhHb1Op6nXkIqP8uuWQ4QOO5ESunhw4cwiUzX
	 sH8E1kisvZ2P31K6cqszjq/SePznhz7+P6wHdRymYsrpl7hVYwTjwn9N4DSp8Gwtv7
	 posRcQwLndqjrSP48EPxIkFVo0nepeQZlpgYm7TLu+N5Do6EKmpgEAuLPNAWyT3xg3
	 HMC4MI3/0qD+u7xMjaYqlLvLHgDoVeuPKsbogCV3SK8REJeIRlFAcJ9gpa3t8hlF3H
	 XLu3HduQS6xbg==
Date: Thu, 24 Oct 2024 13:16:22 +0100
From: Will Deacon <will@kernel.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/4] 9p: revert broken inode lookup simplifications
Message-ID: <20241024121621.GA30599@willie-the-truck>
References: <20241024-revert_iget-v1-0-4cac63d25f72@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-revert_iget-v1-0-4cac63d25f72@codewreck.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 24, 2024 at 08:52:09AM +0900, Dominique Martinet wrote:
> See commit 4's message for details
> 
> Unless anyone complains I'll send this to Linus on Saturday

Thank you, Dominique!

Will

