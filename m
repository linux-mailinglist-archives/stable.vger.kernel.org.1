Return-Path: <stable+bounces-89772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED659BC2BD
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 02:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEC11F2247B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 01:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137251D6AA;
	Tue,  5 Nov 2024 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SabObWe1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30B11CA9;
	Tue,  5 Nov 2024 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771087; cv=none; b=kwBN5mWT949id/8QDIny4BFkWcmLJPrcEoZqoDaU+6eNO7vZ/66fY67BxpT1UfrzazhP/C1vNQ9fTPmMB5j1uwWuqMKLutCgbaEx0m957r0scgJYY2QmFE6gzcDiBQy/9zEUB//dJTppvqb+ajNyzxYxZOcOqmYWNMsMoI818bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771087; c=relaxed/simple;
	bh=N8JI9DgV6aCoCkXQ16J8ZsQVhY2GMhBUO3Dttm0850k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4cZKdK2SWkmeLO6Zk4LC3L50D5PQlaS2xjvPLOERKW524+21ZV3sdNRtFtYYFWN5/2PyBoMLt3bKut5CtEA4PWyswdRDL3oppMw4eEe2n4X7sDwx0al3knQjxN2v1HaWiUKJMQD/sBiY8ga+ZbMRN+JT+MnEkKn9+TnneaVGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SabObWe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43804C4CECE;
	Tue,  5 Nov 2024 01:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730771087;
	bh=N8JI9DgV6aCoCkXQ16J8ZsQVhY2GMhBUO3Dttm0850k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SabObWe1lx0P4F2R+yaxA7OgXX81kMzh6sQVgOEQZvsV+x7UTC+0GJWmPTSRdTbnB
	 Fwl8r8MIOz+F/29MlgrTs1jA+r5RdfQismxmMBFvt0qoKshAJbdIDUHus8BAM0ElOF
	 kaWmLEVjlyRB5oTXTnrfz97SEQWu8OxbudkGc7/qIYGJqaTrzy5XwNxmduCtDxTq5t
	 On7xsULxFljU8z+xy/Gca17bSqIE6zWnm15/2UczszUy2LLwynAW8ZT3L9kOFXZOLa
	 Dp5SpklCEhFe0mThh5LfJWgbb4rdAFcXr6kzvJtjddxilyh2he6iLIP0p7PvttDZJr
	 2deLVuJN81qAg==
Date: Mon, 4 Nov 2024 17:44:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, stable@vger.kernel.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net 7/8] can: mcp251xfd: mcp251xfd_ring_alloc(): fix
 coalescing configuration when switching CAN modes
Message-ID: <20241104174446.72a2d120@kernel.org>
In-Reply-To: <20241104200120.393312-8-mkl@pengutronix.de>
References: <20241104200120.393312-1-mkl@pengutronix.de>
	<20241104200120.393312-8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 20:53:30 +0100 Marc Kleine-Budde wrote:
> Reported-by: https://github.com/vdh-robothania

Did you do this because of a checkpatch warning or to give the person
credit? If the former ignore the warning, if the latter I think it's
better to mention their user name in the commit message and that's it.

IMO Reported-by should be a machine readable email address, in case we
need to CC the person and ask for testing.

That's just my $.02 for future cases.

