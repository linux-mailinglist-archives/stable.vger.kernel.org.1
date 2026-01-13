Return-Path: <stable+bounces-208277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6956D199D4
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 15:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DC1D304225B
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEAD2C3266;
	Tue, 13 Jan 2026 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+KB2yZ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52E2D3A89;
	Tue, 13 Jan 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315821; cv=none; b=RFM+/5pgNFutGNPU6mmr2gp+uR7tRtKNWhzBUVKGNQAY+3r1OEtfU0qws0MJoC177y8IYHALU3cnW39eLFzufZ/YyvOkkciXEWreaeGIjVMv1h130PZ89dmdA5wQoM6OQ2h3rW795OiM63CIGB6jbdqrpLMwRNZVACkixuCAUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315821; c=relaxed/simple;
	bh=EmN27B+vLE+zWD7hsZowS9qkmGQ+k8ojZ/TbQB5EZuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir+teP0fv9YgOGqep+kXQOPGM+v4/SJk1JYCQFVMKVavGBng3gDH6ZF7vN6Qcm8zxbLwwyP9hxvrSLPf3UhKcK7hFEOUKIZGTx2gB0vPWMuQmLSa4hS1XWBre9cNmMn7PwmEkLpUKCNv3isQthXDfCXy0ws5fCOanRaN2CtPyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+KB2yZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D1DC116C6;
	Tue, 13 Jan 2026 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768315820;
	bh=EmN27B+vLE+zWD7hsZowS9qkmGQ+k8ojZ/TbQB5EZuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+KB2yZ5sCX+qho5x4SAbSXqh37FgfHC0TXbp0yu4+7UrMzXhlvUJi2e173AJ/cnm
	 7H09DUBFPmpLhJ9fUa++DkpTbDXGn7N/uUxzljmJkvD99/UmWkTUc9BTMAgd9DOVCe
	 m/gwTlwCnwpl+dqxbF6myTtxcItS/zh1jwVOt8yr7tyeqcUqNaDCDIKULqAhsJb2Vv
	 D2FGDNvDCTMCqmoAZaFKQbVhHT+7c3B3pgRasWc2GCrq5Y5ngijYjKLdrJFDY/t3qd
	 opaGOkODEMBwsv4n8RlT96jDXw/S8WrdFzRag16OQLj1nqbZnNKQ2QY7y8hAHgdnDK
	 Je3+kGH/cXgwQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vffin-000000001Fk-3f98;
	Tue, 13 Jan 2026 15:50:14 +0100
Date: Tue, 13 Jan 2026 15:50:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add support for PICAXE AXE027
 cable
Message-ID: <aWZbpb8Wd8CZjJyN@hovoldconsulting.com>
References: <20251211020117.45520-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211020117.45520-1-enelsonmoore@gmail.com>

On Wed, Dec 10, 2025 at 06:01:17PM -0800, Ethan Nelson-Moore wrote:
> The vendor provides instructions to write "0403 bd90" to
> /sys/bus/usb-serial/drivers/ftdi_sio/new_id; see:
> https://picaxe.com/docs/picaxe_linux_instructions.pdf
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Applied, thanks.

Johan

