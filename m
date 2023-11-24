Return-Path: <stable+bounces-2562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4387F868E
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 00:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5DA1C20E69
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 23:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F0F381BF;
	Fri, 24 Nov 2023 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DE6170B
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 15:01:42 -0800 (PST)
User-agent: mu4e 1.10.8; emacs 30.0.50
From: Sam James <sam@gentoo.org>
To: sam@gentoo.org,stable@vger.kernel.org
Cc: djakov@kernel.org,gregkh@linuxfoundation.org,holger@applied-asynchrony.com,konrad.dybcio@linaro.org,mgorny@gentoo.org,patches@lists.linux.dev,sashal@kernel.org,stable@vger.kernel.org
Subject: Re: [PATCH 5.10 137/191] interconnect: qcom: sc7180: Set ACV
 enable_mask
In-Reply-To: <87fs10k1ee.fsf@gentoo.org>
Date: Fri, 24 Nov 2023 23:01:17 +0000
Organization: Gentoo
Message-ID: <87wmu6oiwe.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Could a revert be queued for the next 5.10.x please?

thanks,
sam

