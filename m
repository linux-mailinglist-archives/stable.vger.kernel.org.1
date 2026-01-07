Return-Path: <stable+bounces-206077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D972CCFBB77
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 03:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B75830FC2C1
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 02:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522EA227BB5;
	Wed,  7 Jan 2026 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt2hRUAX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F95207A32;
	Wed,  7 Jan 2026 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752567; cv=none; b=l0sJKBkNET4YBPmi0la7e4jI6D1nww5w6BAeQTs4GaPKpFm5VdBndexo3x6wEePX1Qirmh4wwSv+26YL1WRKR6B0A/PRa+w5jL2OGOyIlj5peTgl6l3oYtRXjuAusa7646x8NSXTS2c+R5e6jX+0PC0jIvcBRx8mpF83B04Pu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752567; c=relaxed/simple;
	bh=PNW4HVVxZ8G3oxjVQkL+mo9ujZl8FvRW/0AILaRzqCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3/m02KsPRcPLr2CIGs1kzxTXnCVa3oG7c0T8D8frzNjTIs7+Rn0OT6CL9PTzcDUIShr5Mm+BTcoUsL6BgIOmOLSTrPAQ0pm8PxD2b0XsdtqxlIZ8Sgf2JXFPS70JcaA04eKl71h78BfVZfFRzgv44o8Xk6IaqHix++HubV160w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt2hRUAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2203DC116C6;
	Wed,  7 Jan 2026 02:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767752565;
	bh=PNW4HVVxZ8G3oxjVQkL+mo9ujZl8FvRW/0AILaRzqCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lt2hRUAXcMoRQ01j7oO9zAtSwb4KyRih5epLEMLZuvgElDzFj6hvnFLm1vzUizbL8
	 MoXshNzec5Fn+dBocb5dcalWORKg1JMipCWcdSpZnUsY7phvWMm44t5IaH1EyIgles
	 RhohDfnPYrRg8oOwQ6uruEY9yUX0/W/qchElRQFVSZu8IZ1sJ/SBG7KxBo/YAfIW2L
	 Z2A/uMQrDel92WcVe19KTsmtVaTIYpqu5MMnhzT8YJTJfhb9GCtnnTFNqzvkJko61Y
	 zprNKcZaz6sRYApBezD/hKx5y3Cj8ZhSdHVSZAuX3/fne1QOoJbSKbYgzo5I4PWyXW
	 3IDM7Bk6Zz2Tg==
Date: Tue, 6 Jan 2026 18:22:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Ankit Garg
 <nktgrg@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Catherine Sullivan <csully@google.com>, Luigi Rizzo <lrizzo@google.com>,
 Jon Olson <jonolson@google.com>, Sagi Shahar <sagis@google.com>, Bailey
 Forrest <bcf@google.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] gve: fix crashes on invalid TX queue indices
Message-ID: <20260106182244.7188a8f6@kernel.org>
In-Reply-To: <20260105232504.3791806-1-joshwash@google.com>
References: <20260105232504.3791806-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 15:25:02 -0800 Joshua Washington wrote:
> This series fixes a kernel panic in the GVE driver caused by
> out-of-bounds array access when the network stack provides an invalid
> TX queue index.

Do you know how? I seem to recall we had such issues due to bugs
in the qdisc layer, most of which were fixed.

Fixing this at the source, if possible, would be far preferable
to sprinkling this condition to all the drivers.

