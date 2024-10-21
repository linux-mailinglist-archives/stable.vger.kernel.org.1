Return-Path: <stable+bounces-87553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821069A6962
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05BC1C21A86
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE621F4FAE;
	Mon, 21 Oct 2024 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rArMWYVj"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B81F80CF
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515606; cv=none; b=mpeLFFgDlg8Jigyhku7Y+ujpcLgU9eAV9KAbUJZIZFSU/0I+WjNN9KeS4jfI9C/2D2Ktds4Ocg0RLTJCzPqNbWcvOaKEHqJyVCfSM1r5wDS4EvND9s8PiIgcle6ErVJ/J3YjLvL25Xu3U9cp0qaFV0P6HSw1k23IgPtvQLn0N08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515606; c=relaxed/simple;
	bh=yZ3CMKZc+8PnVtLwofZLT0lA9bhoI3978e12XMt3MQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HafKHCbverr571WS7bjYz30hds09VzM7nXI6IE+JkZKNqOQGY7wDRaWCyhh83q/AeNuvFQraCH20eALQ+tVMr60RBCVwcYb81ZdvcRfMXTIxcgveqbCgif+pU4MBCbuVqwpugPhq4wFeJW5ArjH7DHadweMcr8wTNWYeARfKuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rArMWYVj; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VRn89hSrIyjPa+OBI0CQlbMjBXh7be4eOZz1A0761FM=; b=rArMWYVjDKzj6JT4qykqkVM7E5
	qx7R+DQZ/7auzlah1JzkXd169GBoCCruSgwkuWvlK0FSsjcbG1Xkn1yQMobIWPGs/h9YuiEDns/63
	qBPU+BUvoeEK2lVsokPc7NyY9KGEEe4isdsh9dYkOmcDGB4zyO5Q0PkvyLUawdND0mGLEvyWBWSkw
	2ZbGA6LTGms+zSVkbnuf6R/D5pBhHb5rRKuwWGJDmYVcfBV6N5I9uZaQ93+IgpLEP/gHHzXX55wPw
	3TYEje8NDSy6vcdEldXGze0F2sXUYoW/nY+fL7rsyNynEIZtNV4lNNxlreaRT9e7BmAlGV6TwNuFF
	UENS2/AA==;
Received: from [187.43.135.173] (helo=quatroqueijos..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t2s0n-00D9zS-6h; Mon, 21 Oct 2024 14:59:54 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.10 0/1] Fix lockup when splicing 0-length buffers
Date: Mon, 21 Oct 2024 09:59:41 -0300
Message-Id: <20241021125942.2090200-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When splicing a 0-length bvec, the block layer may loop iterating and not
advancing the bvec, causing lockups or hangs.

Pavel Begunkov (1):
  splice: don't generate zero-len segement bvecs

 fs/splice.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


