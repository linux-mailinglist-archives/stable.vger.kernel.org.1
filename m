Return-Path: <stable+bounces-155275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DCAE3398
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 04:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4168D3A78D8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 02:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093D17B50F;
	Mon, 23 Jun 2025 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJpTUd+x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215D171A1
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750646009; cv=none; b=DNvlNPA+45a+BYqZ7KuaQLQ/6amTuSjabUd8mpgUAjZFoSfaj4bu7vX4ygZvk3xSjEVGqOHnSFFPR1+TPtoyM6nzjqIPSMkoIz+314WZBdo1kWKncJMGKlUYV8fNlYrJ5MjhX3PSyNUwPkxkuBZ/+LjMo45HgeIpk+vkZzH/e+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750646009; c=relaxed/simple;
	bh=xZkdT27wC1nZTeXpsuO30Eo6VJuaZoPSrMAhqk7fTI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6XsKxrmkv+E3NanNfm7kwQVdsLIYC1I9ecKjffSQT/Kaj30N8T1ZcMAJbnGeUS7LBp86i3LfSpsMj1RgRV2GMXvRylmjS+X7MW3QeeWNYQS9G6XUxKKV7WLZ6j9uL3Sie1tDJy2l/y5dkEBik3Ez/ruvlGQLIixEdLEtAgendE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJpTUd+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB03C4CEE3;
	Mon, 23 Jun 2025 02:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750646009;
	bh=xZkdT27wC1nZTeXpsuO30Eo6VJuaZoPSrMAhqk7fTI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJpTUd+xFCqSo0KI/4KJPyUCkTRToa0VByYmVOnkLj4pPSTVmV+JbhbFDMdwVmZnC
	 VRi/8OkH39zUePEW8K+gZi5WKQubsTzZXwYOWhh5xKiN2BF6xksn8tvxXgIbkTX4hv
	 FwEFpzcA/d5ygVpqyukh4eegBNBgaLLigivwoRb/AMGNDmBqbqlkNvOiTjTXJ+FUyL
	 8gNsebXtwF7kA+zTKf/djWH0WMH+ucjX4TSUqxgES77RcUx1WeadRx02K++fp9rIJq
	 Ap/jBkJYznji35FL68vkfX+RddnLoEh9+P9r/x1/qsNvEhq694ptJd9VhK7McUQ0MR
	 6wCDqujOSEY/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@loongson.cn
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 6.1/6.6] platform/loongarch: laptop: Fix build error due to backport
Date: Sun, 22 Jun 2025 22:33:28 -0400
Message-Id: <20250622220015-a186a2a87868d372@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250622110148.3108758-1-chenhuacai@loongson.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

