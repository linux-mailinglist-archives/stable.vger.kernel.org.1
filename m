Return-Path: <stable+bounces-15305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD028384B8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55D01F22970
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA7974E06;
	Tue, 23 Jan 2024 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u+oFOXHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CF74E09;
	Tue, 23 Jan 2024 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975467; cv=none; b=pvjaTl7E9N5VNNNhvcDWMWefT/wRt4AyEKyZEqyEUbyq0ALX6uYiXsHwFFyqQae+zOvmXfnKVtgfzlv/CISgU3U/A4tGknb0vaOsaojhOgNcy8l07dZKKPJh8WP9P3OiXrueOXAhmAvakNvmAnkQfft/zVZpk0cSHxKAj++FBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975467; c=relaxed/simple;
	bh=mXhM9nzqNZO5PhBpGbl/IOx0mKt/15wjgEkc4+6QAdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngHXggwlWx46pkN5tmpqXe/wWjvAn/BCgHu4NnOWzBn53QWe3KOwPZNLbWoPVDbSkEml2F1XzlskGlq7gJd2ovcCg6PPdm+ruVszQJ0dnszqtJ+rzrBzgP481D4fUoKZZMtPCDQVKLzCyFk8+rH0JKLQBWvedJzEZPoDJpPEHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u+oFOXHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D447AC43399;
	Tue, 23 Jan 2024 02:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975467;
	bh=mXhM9nzqNZO5PhBpGbl/IOx0mKt/15wjgEkc4+6QAdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+oFOXHjmzNi3JkyGC0WNTwsQ1VTuoHmWcZqJBC3V5euNexOgTURPjm3faUdyUdic
	 aQRFxiHmx6DFYhqejeubBLLeqFDmt/wXikDi8dWlWwwP7QVdkWNrm8QbGzBwDLw8Z7
	 GcprNqb4BC5925JKwKs27bcO5RMnVeav2ecz6ffI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tadeusz Struk <tstruk@gigaio.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	stable@kernel.org
Subject: [PATCH 6.6 423/583] PCI/P2PDMA: Remove reference to pci_p2pdma_map_sg()
Date: Mon, 22 Jan 2024 15:57:54 -0800
Message-ID: <20240122235824.930800724@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tadeusz Struk <tstruk@gigaio.com>

commit 9a000a72af75886e5de13f4edef7f0d788622e7d upstream.

Update Documentation/driver-api/pci/p2pdma.rst doc and remove references to
obsolete p2pdma mapping functions.

Fixes: 0d06132fc84b ("PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()")
Link: https://lore.kernel.org/r/20231113180325.444692-1-tstruk@gmail.com
Signed-off-by: Tadeusz Struk <tstruk@gigaio.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/pci/p2pdma.rst |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -83,19 +83,9 @@ this to include other types of resources
 Client Drivers
 --------------
 
-A client driver typically only has to conditionally change its DMA map
-routine to use the mapping function :c:func:`pci_p2pdma_map_sg()` instead
-of the usual :c:func:`dma_map_sg()` function. Memory mapped in this
-way does not need to be unmapped.
-
-The client may also, optionally, make use of
-:c:func:`is_pci_p2pdma_page()` to determine when to use the P2P mapping
-functions and when to use the regular mapping functions. In some
-situations, it may be more appropriate to use a flag to indicate a
-given request is P2P memory and map appropriately. It is important to
-ensure that struct pages that back P2P memory stay out of code that
-does not have support for them as other code may treat the pages as
-regular memory which may not be appropriate.
+A client driver only has to use the mapping API :c:func:`dma_map_sg()`
+and :c:func:`dma_unmap_sg()` functions as usual, and the implementation
+will do the right thing for the P2P capable memory.
 
 
 Orchestrator Drivers



