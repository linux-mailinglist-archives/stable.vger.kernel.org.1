Return-Path: <stable+bounces-41387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AEA8B1620
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 00:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CB01C212C1
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 22:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64016DED5;
	Wed, 24 Apr 2024 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oR/wKDKB"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ECD16D4CA;
	Wed, 24 Apr 2024 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997303; cv=none; b=HyJeRmAFCs2Y8JeAQlNSnOwKSKWObBJAP5Kt/Uhc3bN2NUwiTuZ4f653w5/m+vT4/ZCpiyKbcpgRQX9vfFA81dvnRlv80N5vecBLalXKHU2v6cIQ2CUvrMU3JnrMGsRS1w5ODCRS56LRjejI7HbqibH4gYu7nYzy2LixpAwPD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997303; c=relaxed/simple;
	bh=ypoBNr5DO1Bo5ABHHdt/O0fZK1yh/4/Xe2ztB9x6jWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hWC+zUcErc4l3I1o9+uxzkLjdFtgZtYQKmmlzEiBZIMikTJJZL0HSclGZ1DQd4CCCEFtnaily3chpAWBeJLYOFZ9OXAOFBDQdnGlRkmpcZ0Z8eaTvnyYHvh/QxlI5swD8Dajem7/4cbTJ7wZ/UbaZY+Zf7KZLIGNQ1N/PUvnT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oR/wKDKB; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rCY6b8Hqgt+J1IU1JUohIhVbnS/F8XQ8nx3RmxOLXK4=; b=oR/wKDKB7WSnTCM67FwqHelnP0
	f9ubAqWLZ8asqhcWHrRg6pyR+UQJiUJCm0wlwuVwpbrg2m1S0OU6qIzESeXkipODozx1+BJu52ur/
	prRRpdQXe3TlIk6/8pYac7Bjkt6jmu7Xvo7rZW9UYyUAcUu7miEQsPPU7VkoQe4yhBHkExhOgbDx8
	OvaqUZxWI88p0yRm2V9P6Tl/TQlnjr6ZUBg4BjtxwwAJ8EdjePq998Az7KUttXf7194pwAJk5ZghD
	Jh0Gerj+q4PT/l6HC8MFi7YFEwmLPA9kmoefS98a0wIAfo8yU7rPQGVSgnGATxXZjaO/NT/yZ1Mc8
	HJZZ/S4A==;
Received: from 179-125-71-233-dinamico.pombonet.net.br ([179.125.71.233] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rzkza-008LGq-Pz; Thu, 25 Apr 2024 00:21:31 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5.15,5.10,5.4,4.19 0/2] Fix warning when tracing with large filenames
Date: Wed, 24 Apr 2024 19:20:07 -0300
Message-Id: <20240424222010.2547286-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The warning described on patch "tracing: Increase PERF_MAX_TRACE_SIZE to
handle Sentinel1 and docker together" can be triggered with a perf probe on
do_execve with a large path. As PATH_MAX is larger than PERF_MAX_TRACE_SIZE
(2048 before the patch), the warning will trigger.

The fix was included in 5.16, so backporting to 5.15 and earlier LTS
kernels. Also included is a patch that better describes the attempted
allocation size.

-- 
2.34.1


