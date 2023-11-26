Return-Path: <stable+bounces-2669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2A7F90FF
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 03:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EA31F20D46
	for <lists+stable@lfdr.de>; Sun, 26 Nov 2023 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7607ED;
	Sun, 26 Nov 2023 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jidanni.org header.i=@jidanni.org header.b="J310f8s0"
X-Original-To: stable@vger.kernel.org
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD8FF
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 18:40:37 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 590B97A1DCF
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 02:40:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 076537A1C41
	for <stable@vger.kernel.org>; Sun, 26 Nov 2023 02:40:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700966437; a=rsa-sha256;
	cv=none;
	b=mEaj0NhX93nmGt17DS73Ic3z9FxrjLg672P6+A4TgRlE41QkH+6kC1dsNiI0y+X9Gbrypt
	FZyjMFqWNW7JYkEAg7RzKRxGv69KoeOG3mtRA/qChsBYhKpeRfKHFU5tKEuAgPWh/CzCUM
	5kGBMvU6yS510jy2BWXDbnU0CYsYaawKYwfS1noIuXe+EwclVbY/TAlm4oW1yGNADkVBhy
	Sy/44bI6M4ye+dX+M3244cwSF+tvu3fCJyUxzn/Zz5ILpp2Jtjy2qV20VsKr1p0KHiU0BN
	sgH4RvqjUGqrvdx8Cq1IVMnYOXrkBNkoNEjFsSAUvOQGKrG1qmgrbSjWaVPlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1700966437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=gCXMM2dAe5oEZv5vh5PzSGav7eGCY33d2PTkwHt+8nc=;
	b=nFm6Qs3lkxUzSI+XrrRskg+CpvJk2XAEll/Gb5AWKyqYki9JHMcQbbhIIoq+SprlWZ0UEt
	L/LdukLrxGf4X95pkcZPmtkSPQVXrXviRAcy5dUiU1EAdc2ITczezv+E6105LSze1HxBEA
	ukqe1+JmYU9+FDE5LTdLoP3V8cqslFWFiv0Ha4UeQEv4yyHtxEnrU4BQnJMieL/zsY9UgS
	uFng7rr42ZkGxkzepUp3KZIh4wqa29V9xg03mXDwsQaKISA6lkLCx4NdAiNOJm4N+4AR8f
	JG95bcG2Z/WdppzKftUgeonOYkCM9RJxP25lipzninJG57NacSibXuxNdbHBCA==
ARC-Authentication-Results: i=1;
	rspamd-d88d8bd54-pdhmh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=jidanni@jidanni.org
X-Sender-Id: dreamhost|x-authsender|jidanni@jidanni.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|jidanni@jidanni.org
X-MailChannels-Auth-Id: dreamhost
X-Trade-Stop: 361b967a459eee9e_1700966437122_3526577278
X-MC-Loop-Signature: 1700966437122:1109573869
X-MC-Ingress-Time: 1700966437122
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.102.70 (trex/6.9.2);
	Sun, 26 Nov 2023 02:40:37 +0000
Received: from webmail.dreamhost.com (ip-66-33-200-4.dreamhost.com [66.33.200.4])
	(Authenticated sender: jidanni@jidanni.org)
	by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPA id 4SdCd068HJz98
	for <stable@vger.kernel.org>; Sat, 25 Nov 2023 18:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jidanni.org;
	s=dreamhost; t=1700966436;
	bh=gCXMM2dAe5oEZv5vh5PzSGav7eGCY33d2PTkwHt+8nc=;
	h=Date:From:To:Subject:Content-Type:Content-Transfer-Encoding;
	b=J310f8s0UZzGsOGiTBwf6xyYU1HmTZEOUg3dTyZYNI0WYrnNlIRpTqXdXZrDRMKLE
	 B8tjwCxxjFS5xpIyIidyo00W4NiUcKMt7U7c7TeiQsV7sctSstwAwH3iQQOAwZNd50
	 PxW1TLo/TedghygeVuXmIQEG0/kE6LKfmtH0QAXRuubbllPa+CRegz+/i7w8Fbz2aC
	 zPz6dPrkk16ph76KD8mkkpuLctBeBXccmtUxZl8XqYkGNphRIHkFd/BWOidoHmmxmP
	 1/Hfj2aM8TEW0xXlL8cJPcbow4WbfjiMARx4XkRPv1sBFEdFYzypusTQbARwGF7KXH
	 1ZGx+LwiGFPSg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 26 Nov 2023 10:40:36 +0800
From: Dan Jacobson <jidanni@jidanni.org>
To: stable@vger.kernel.org
Subject: Say that it was Linux that printed "Out of memory"
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <9399ce7b9ffa0ff6da062e9f65543362@jidanni.org>
X-Sender: jidanni@jidanni.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

In https://github.com/szabgab/perlmaven.com/issues/583 we see to find 
the simple answer to "What printed 'Out of memory', one must consult the 
experts.

Therefore the "Out of memory" message needs to be prefixed with the name 
of the kernel, or something. Anything. Thanks.

