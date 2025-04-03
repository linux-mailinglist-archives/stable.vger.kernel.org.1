Return-Path: <stable+bounces-127489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B767DA79DC6
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 10:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8667A6154
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 08:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41D224B15;
	Thu,  3 Apr 2025 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFNiwOUs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047921991C1;
	Thu,  3 Apr 2025 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668107; cv=none; b=s9io7dR4m7DXSe3kVWpH/vyXfV9l0QHfk472XfEe4CX7Yff7ve2cowsLekVmmJLICbnfsf4TjlkAOF/jTa4F8dCzDc1MOlpOWcDJJZxO4wLwPo778i/T2mx3w0DAPUUUhmCSVSoHN3qhgOlHAxtFRRDJvgM/t3lk2TmBEydpGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668107; c=relaxed/simple;
	bh=d60uPl3O2WNH5zTqvohDJrR3czaNKY19sBaIVAZLdEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kuip9jl+3cCXqK0qGKFk1VUPHrovfGqgQGtVIa2H3b4kErsxoQNlcp11RAH+WBhKrjpaWOxV7060AzJV05gF6lZ/qNZBLi5f4knGmNxksJqxqVtKZkB0WtMhq0fFod9W/CKE1k4/l3shKFMfd491rkvMfZ9D2DC96FHn7CH0Rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFNiwOUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B46C4CEE3;
	Thu,  3 Apr 2025 08:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743668106;
	bh=d60uPl3O2WNH5zTqvohDJrR3czaNKY19sBaIVAZLdEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFNiwOUsMEPYtNg5Bx6D9qMpJC7DlLB4iItNbA4oWNdMZ1GvKPtq2zq5VLKCdHSGj
	 EVzfidldRIQpWsLv6FhFTspFjE541FQSpDquAwIUk2JXUrNIQ/Qw1zif6wDi0/4BkG
	 7Qz697KSheeDzgcWYUJAwXb+kCnhw9eornzE3S+Hqr8o2siesRjz95sx8RzqCGhhYd
	 0rA46zwyb9d7h5BEejUNDhJsdRLhS1f38bZ2ahnWmjZICj1iT33Lel/9PfsGZCX+wz
	 vo+94QV8+2XIMg/6nu0zkMGvO7rHi9CoEzIl0j1oJWpzn8p2dqNyVd1Z6jQWt73fcB
	 trbAPoHObZ/aw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1u0FjC-000000006t4-3pw4;
	Thu, 03 Apr 2025 10:15:10 +0200
Date: Thu, 3 Apr 2025 10:15:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, peng.fan@oss.nxp.com,
	michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, maz@kernel.org, stable@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [RFC PATCH 1/3] firmware: arm_scmi: Ensure that the message-id
 supports fastchannel
Message-ID: <Z-5Dji5dbDsKXZE_@hovoldconsulting.com>
References: <20250401122545.1941755-1-cristian.marussi@arm.com>
 <20250401122545.1941755-2-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401122545.1941755-2-cristian.marussi@arm.com>

On Tue, Apr 01, 2025 at 01:25:43PM +0100, Cristian Marussi wrote:
> From: Sibi Sankar <quic_sibis@quicinc.com>
> 
> Currently the perf and powercap protocol relies on the protocol domain
> attributes, which just ensures that one fastchannel per domain, before
> instantiating fastchannels for all possible message-ids. Fix this by
> ensuring that each message-id supports fastchannel before initialization.
> 
> Logs:
> scmi: Failed to get FC for protocol 13 [MSG_ID:6 / RES_ID:0] - ret:-95. Using regular messaging.
> scmi: Failed to get FC for protocol 13 [MSG_ID:6 / RES_ID:1] - ret:-95. Using regular messaging.
> scmi: Failed to get FC for protocol 13 [MSG_ID:6 / RES_ID:2] - ret:-95. Using regular messaging.
> 
> CC: stable@vger.kernel.org
> Reported-by: Johan Hovold <johan+linaro@kernel.org>
> Closes: https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> Fixes: 6f9ea4dabd2d ("firmware: arm_scmi: Generalize the fast channel support")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> [Cristian: Modified the condition checked to establish support or not]
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Since PROTOCOL_MESSAGE_ATTRIBUTES, used to check if message_id is supported,
> is a mandatory command, it cannot fail so we must bail-out NOT only if FC was
> not supported for that command but also if the query fails as a whole; so the
> condition checked for bailing out is modified to:
> 
> 	if (ret || !MSG_SUPPORTS_FASTCHANNEL(attributes)) {
> 
> Removed also Tested-by and Reviewed-by tags since I modified the logic.

This still works as intended:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

