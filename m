Return-Path: <stable+bounces-194883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043CC619F3
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7210C4E3AE6
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2D30F7E3;
	Sun, 16 Nov 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSPyG03Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E72D6E74
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763315290; cv=none; b=t8dNsVLxuDcv81Bgo8MuXFQaFdk4YCrpMHVtg+4r0u0EF5Y5ZV1wEkaPrbrtgacd3oOBswcxmD550VMcCZTHQP9GKMQ6Ep0Gu9TUhSgPZ+myaRdxFx+GQ0+2ysF9ZJPhJA7nFZD8RGYzvIpt1NM6t9mpE9R/TtjoNt9Y8fqJiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763315290; c=relaxed/simple;
	bh=g7wk2LFKybiWeswNtrUaRK1k+AO3Gs7PFB5GLfEjcuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atepSDRPU/W45gUAHnSSb5YtcBoqfxBP7VDopqXs0ZTz4mSIkiRWpewyrYbK3r/a5eDWbR34n9FMdqPhun2Ofb99PsNPpoh8Lq0EKgMwcWzQTeQkGJd/0TPbMYSdMBYV9jrpt2Yo1nD+rY14vXYNAXzJfXPb8Zlf+B42vFv/Oow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSPyG03Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B729C4CEFB;
	Sun, 16 Nov 2025 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763315290;
	bh=g7wk2LFKybiWeswNtrUaRK1k+AO3Gs7PFB5GLfEjcuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSPyG03QPDX2JL/CLzCHXc2y+7lo0jFes3I4sE6ZAj4fVUSpeyD9GHY0fkZb8BwYm
	 v3YSAI10Qu2N4LiwztmEaNMsDX3h82BZVJMw2eHEOLLy/OXGf8WNmO9GF1EFnxYiQB
	 B0blVjoGVpoM4wF/go2Kq+JdCYrAKFvBLtqP507fpde+yL7FkvQuujkXaBq09q785l
	 aMT/GxlzKoLL678VJeHXlb2yZnO6z5RXUEJOWyJqIQ1HY1A1tEQIRt995Ns3niHpc0
	 w7+RRC0b0/dFRA20//QeTMutmZ15gF/R7a/sFuTe1YwIeOv5JEBl9p19/FaGaa1PO7
	 Nx0mvlFQ5574A==
From: Sasha Levin <sashal@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.6.y] net: allow small head cache usage with large MAX_SKB_FRAGS values
Date: Sun, 16 Nov 2025 12:48:08 -0500
Message-ID: <20251116174808.3651574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107013701.1411-1-jetlan9@163.com>
References: <20251107013701.1411-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: net: allow small head cache usage with large MAX_SKB_FRAGS values

Thanks!

