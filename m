Return-Path: <stable+bounces-139262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD63AA589B
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 01:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0AC1BC8221
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DAC22370D;
	Wed, 30 Apr 2025 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b="bLAL+JKt"
X-Original-To: stable@vger.kernel.org
Received: from puleglot.ru (puleglot.ru [195.201.32.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8342248B3
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.32.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055169; cv=none; b=bJPbMHG4gPj2uszU/b80d0oxCJdnXRi749dkbqf7orGXtA7JQ7LPgiscB1ENQVGQbDwkYEdsykQM8pX0QeBGUQnDrP5/+DRZLN+wnw/w2y0EvyFLdb3UNr1uJ/h5hOWeO3FLhp3jDfwYNijeW8eEZKgG38muhzvgAhA4cUGGtjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055169; c=relaxed/simple;
	bh=b5jsbyZkLCw+lpP1pVZuMyYDoNeTH1njEnxiHYT59jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2EMxQXnBHdX7XuclIAab0BJgOIhS9V6/Dcf3c1iPjcd17gU3KUvceL0Bs21gP85WHyy8j+v9fqFiwZcI/J4w3+rl3v9Xg1PPFv0mlRT1HNeA7f3Y/yusHSVH2neZ8Qxsx/NjROpzfH7SfMYgshiVvAWkJbcnjMxt/TBiAOpnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me; spf=pass smtp.mailfrom=puleglot.ru; dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me header.b=bLAL+JKt; arc=none smtp.client-ip=195.201.32.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tsoy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puleglot.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
	s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=b5jsbyZkLCw+lpP1pVZuMyYDoNeTH1njEnxiHYT59jo=; b=bLAL+JKtVe9FuLf3V9qn6oJSnZ
	FLKXW/kr53l4mDEviqSe2ddC76C0jnj3Ob47SI35rRJxbsV1JwlsWC/MA08mdIfQPPB0D2vVXuikx
	fzitWz+/qoFuigLH8k7V+I6460fp4jSa2uNStQDFR3HlGyViIP64QQ1ugxYbv94CbG9k=;
Received: from [62.217.191.235] (helo=home.puleglot.ru)
	by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <puleglot@puleglot.ru>)
	id 1uAGVj-000000019kN-3j8q;
	Thu, 01 May 2025 02:06:39 +0300
From: Alexander Tsoy <alexander@tsoy.me>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.12.y 0/6] Bluetooth: btusb: add a bunch of USB device IDs for Qualcomm WCN785x
Date: Thu,  1 May 2025 02:05:30 +0300
Message-ID: <20250430230616.4023290-1-alexander@tsoy.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: puleglot@puleglot.ru

This was tested on a device with USB ID 2c7c:0130


