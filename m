Return-Path: <stable+bounces-83413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B204999B14
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 05:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BA91F246C9
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 03:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8134E1E130D;
	Fri, 11 Oct 2024 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNuQ9DRQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AF12E5B;
	Fri, 11 Oct 2024 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616657; cv=none; b=n0jJ4sarolc32ydc+5pB9GAF+RKZHucdDt/MHrimL7JrQFSPSOMlE8XaNs15tZsjdb3Ge+ZG21RhwKuyWGmQj3pR9N+CR68QlLwYn+8RNELpIucrPLzU1Tc8n7uxSxS5IYanxUeKmarVpcHUBbepKkZbZI7QG/67cq1e93D2ZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616657; c=relaxed/simple;
	bh=Ahf7hOb4kthw840y6W9cnC0lmdkLkCWjbEtMzFw/BqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0v6rEfoFVO3fQTfEXGe2mQRva6sB1qMkaqPQX2/JWLCmgjGn3Jtynbcih2GE013DqDLZPQDVmlWHV0KQl7D9k2YwqjKj4MTkodYo8/mi8ksnA8265Rzt1oiaXibM6w3rOkOUThCye0wR/xpbI32x5MBoRgHM1rv45bqZu0iCGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNuQ9DRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2808C4CEC3;
	Fri, 11 Oct 2024 03:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728616656;
	bh=Ahf7hOb4kthw840y6W9cnC0lmdkLkCWjbEtMzFw/BqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNuQ9DRQyGh4e2O4nLpqsfB/JoaaWPHswYwgzRUqKCsX6otObXTir8Nm4RTcFoZux
	 TaKGx+NDftvJ77xYb/BUQENjYmRJjQCOPWixuA9A0U30WZ0E0KKPXG/OIdQMKUSDTd
	 fFYal4c5d3GklNm+ebmRzup9XdXKp9FycJNksTSF6oPGWO/npuQLcDXsEqZOro4RB8
	 IsiF+le0HNzcaFI4uATnf88/I5GXILT69e9T0B4F/Yy/ypw34pNmuEExJYViDU7oJ5
	 l6v030GbgHOy0Ldx89CZZ+THSDiwpnn+PxBaIzVIHgwt5Mw/u3VoKBkqazQ27655Nh
	 WdOhlvIc9OlLw==
Date: Fri, 11 Oct 2024 11:17:32 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Prashant Malani <pmalani@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cross_ec_type: fix missing fwnode
 reference decrement
Message-ID: <ZwiYzGzbfK4rmOxq@tzungbi-laptop>
References: <20241009-cross_ec_typec_fwnode_handle_put-v1-1-f17bdb48d780@gmail.com>
 <7767afd2-0ada-4cca-8861-ccdc874d555b@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7767afd2-0ada-4cca-8861-ccdc874d555b@gmail.com>

On Wed, Oct 09, 2024 at 09:00:41PM +0200, Javier Carrasco wrote:
> On 09/10/2024 20:55, Javier Carrasco wrote:
> > By the way, I wonder why all error paths are redirected to the same
> > label to unregister ports, even before registering them (which seems to
> > be harmless because unregistered ports are ignored, but still). With this

I don't know the context a lot.  But it looks like just a way to unregister
the registered ones in the error path.

> Small typo in the description, should be cross_ec_typec (last c is
> missing). I will fix that for v2, but I will wait for feedback and
> reviews to this first version.

Also cross -> cros.  Otherwise, the fix looks good to me.

