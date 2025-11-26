Return-Path: <stable+bounces-197004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1700CC8999B
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 12:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00A03A4671
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 11:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B414D3246EA;
	Wed, 26 Nov 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR+G8rFG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8920DD51
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158020; cv=none; b=ZmP2BryGBa9KyIsXHSsA1dzklS9cKKRGAEuNNJhWjt9oFIbVHH0mKjbsTHTpAXhziXEzy2ZsDDVrFgWV9ICVHcEiXeAprJ1GBMfcF1xDXY83Olk6ptlDmtI6rMxgsT7mTE1PP+YprrZAOuxv8TAlnMvimi3GdjBxxfImMeP8y5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158020; c=relaxed/simple;
	bh=Ro8EHdUJEwzPbPLwoc7zvH3VdKOUZ5V/thVBuxCBsMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkX9IN4Yf/31Z8twikp+6ADbvCbIU8/OKEtiZ/qZojfNssu5cC7y8fBlpJyEztoHrzT30BhDsBjIrChGGpiy9H8lY1BirbMqrQBRUdp3lQzo6IEOzHV87iEDSmONTMfyIfKPY83WeTnLXZe9tFtdVYEyzYUbvu7UKf69BUJOSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR+G8rFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63881C113D0;
	Wed, 26 Nov 2025 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764158019;
	bh=Ro8EHdUJEwzPbPLwoc7zvH3VdKOUZ5V/thVBuxCBsMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JR+G8rFGG74390PvWnDI3D3c3UuVnMVGbOYt8SK5CwCTPJJ80+p+QNqTDlC8cbKqJ
	 LQa2FqUu/7+KCQN8gC1PTeS9MXQAgZTuzSjlkUT9EFwPlhCz81J8L9US5LThye9cHk
	 eYK/biT+Mxh+c+Ht1jee2IUg+q3m8G2QoDPaXQiPqoupwNaYVxDBYKTBq7VyCEhK9+
	 saB5Zm8pdcQkouQiMvkqk5qBTfhg81BNVhw630BGHMJdjA90TLVFj2NstV5Csp2RPk
	 vA239g9RqIsZCLxRwdH76AU2+c9Nj7BfsLs9+gnlxw40FedE53JYXWkDRJyVa4zCUJ
	 FnVB6pJ2NbCdQ==
From: Sasha Levin <sashal@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org,
	linux-kernel@ver.kernel.org,
	Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH v6.12.y] ALSA: usb-audio: Fix missing unlock at error path of maxpacksize check
Date: Wed, 26 Nov 2025 06:53:38 -0500
Message-ID: <20251126115338.1353642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126100839.42855-1-tiwai@suse.de>
References: <20251126100839.42855-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.12 stable tree.

Subject: ALSA: usb-audio: Fix missing unlock at error path of maxpacksize check
Queue: 6.12

Thanks for the backport!

