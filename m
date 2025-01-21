Return-Path: <stable+bounces-109598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68971A17A92
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 10:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7166163765
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 09:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C41C1F0F;
	Tue, 21 Jan 2025 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uj+JLJkR"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8603BBE5;
	Tue, 21 Jan 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453279; cv=none; b=nwQzq2tdggnQPtMPa6yh/+24NnNIcum+lBB8CrXPmg9IeWjFpHQDU1wAN8lexQ6fpNvbnrdU0bveckxn92JgpvoP/3RIaMhU9TBOLlkqWEZEGgmU9KYWxrqAakyCHj854fy6cAQCQTRLwg2wi+sszEJj107H5a1KpXLJvIyny7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453279; c=relaxed/simple;
	bh=C7gflKXd4zII/GeDYeSETV84zTda3Rb++G9d+oXje/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VvbP2uNMXyiu9SJRvNN8CvBm3T0i7QoX9WV2BQw00YcVyZ0yFj0FD5dAM+4ShTPwC1NKQPIVbCNHkEOqaiW8CJMXqjcwR/YgXnNWtPSci98+5UZj+XIjWvKRJ7+w+FEK/APnT8woB+6aHU+iNnL321+/AhTOe5JphVc/MjRIN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uj+JLJkR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CDC9E0003;
	Tue, 21 Jan 2025 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737453275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7gflKXd4zII/GeDYeSETV84zTda3Rb++G9d+oXje/4=;
	b=Uj+JLJkRtaPbnigXIXPg8UWaH+8AI38qbOhokkH43AUYlE+GnB/qdLcTSxvqM4huhkJrJF
	NzbIoSnzhDqzFWWDVT6c29UTgmTj3zsqHArTBYs/Oad171RKWY3MYrR7vvZx4cMfGaarwf
	EJjJ2IKgkx5LIpAkdLA1nUMCZo7Uhr4Ecm3msgRJoroZlcgDCLkdzB43PTWgOs3W402o6s
	1dDPZ3lHoz65eSI/8lHtiYrGiGQ/niAFRTvgxPNZzQp2dZsLMyTv6nWc/HVu0VO/CfDXiU
	PqLKLv1JVzm0Zc4/m1z9lwfn2/j9NDneq7B9wCoaNfiyUfp81ijldhU27vAjdg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: niravkumar.l.rabara@intel.com
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux@treblig.org,  Shen Lichuan
 <shenlichuan@vivo.com>,  Jinjie Ruan <ruanjinjie@huawei.com>,
  u.kleine-koenig@baylibre.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mtd: rawnand: cadence: fix incorrect dev context
 in dma_unmap_single
In-Reply-To: <20250116032154.3976447-4-niravkumar.l.rabara@intel.com>
	(niravkumar l. rabara's message of "Thu, 16 Jan 2025 11:21:54 +0800")
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-4-niravkumar.l.rabara@intel.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 21 Jan 2025 10:54:32 +0100
Message-ID: <875xm8pk4n.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 16/01/2025 at 11:21:54 +08, niravkumar.l.rabara@intel.com wrote:

> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>
> dma_map_single is using dma_dev->dev, however dma_unmap_single
> is using cdns_ctrl->dev, which is incorrect.
> Used the correct device context dma_dev->dev for dma_unmap_single.

I guess on is the physical/bus device and the other the framework
device? It would be nice to clarify this in the commit log.

> Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD su=
bsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Thanks,
Miqu=C3=A8l

