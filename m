Return-Path: <stable+bounces-104285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC79F24D2
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 17:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C524F1885CAD
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 16:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630A556B81;
	Sun, 15 Dec 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="O/lO2tpK"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B11EB2F
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734280678; cv=none; b=tTXXUbp1esTPy93CgFMZvt/6RgoTwSLBdgC+t++ipoXQa00qt/Tn98XyLy6kyBYZxy0nsqAFUO1qI48BR5XLmIEQYg+O46mKRnk/PT/+C1awzM+0y+B73MZZC/tSoVb33IdOacRTr7TuOaY3g/OyT1ULR4c0i1KXwqQ33emdXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734280678; c=relaxed/simple;
	bh=qjGFWPeteQaLT3GjoOJ8EkFipWSORwGV/1xMPCHFnPY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jqzYZvQJkoYWcWh6Qm+qfEq2shBzTYRw0H8439mgl2ge68uceNGt6PydtKYlfKcR/s6SItnuBEnlAQQFRgbwloMHj/F7REZp2dXWULLglc+Xubo6Vz6oLQb+u17Om6mgnScajfDvN/rfo1n0WedXe13uWxk4EL/wz1UfzEONzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=O/lO2tpK; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <719b5eb1-a5a9-4dbe-b3b1-399fb299bafb@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1734280674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t55Yi26H4YzMxMzu8fM7SADF2BxEIxzRgiIz32ukCKg=;
	b=O/lO2tpK8TBsC6BNSGwonrfGColR/4Sf/PuVR3sPfM7rZqPdhGXdZQNPVDeKZk6Kdf1PmD
	I0ZpGC7WPJvEuDirkc+kEey12xvMQuq2xTx97IoCtIKwun8ihcFfM0vVj1Q+4yYMEEg6Xx
	WZfG3pfty2FirHzFRnaWRFb+HMIFCOLDAE6yhTkOuER/yYvE7HyAzGMmKaAnsRlTBgkOfS
	kVlz2Df/8u+Y5xN3xTlSsWWkagJW8pZ5oLrX2BEwVbFxqdpYHo0fbeJajr4lYkdj9JlUxH
	Mi57kEt8cbXZYdeWHxwwcu8/Wf8MtLJ7gd9xxgdLJL2pYWfV4jOJuMF9hs/96Q==
Date: Sun, 15 Dec 2024 23:37:50 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Subject: [Regression] 6.1.120, 6.6.66 and 6.12.5 crashes on Vega with a Null
 pointer deference
Organization: Manjaro Community
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

Hi Greg,

Due to backporting 2320c9e of to 6.1.120, 6.6.66 and 6.12.5 kernel 
series we have the following bug report: 
https://gitlab.freedesktop.org/drm/amd/-/issues/3831

The commit 47f402a3e08113e0f5d8e1e6fcc197667a16022f should be backported 
to 6.1, 6.6 and 6.12 stable branches.

-- 
Best, Philip


