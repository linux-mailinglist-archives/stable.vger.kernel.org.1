Return-Path: <stable+bounces-8240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E9681B469
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 11:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DCB281698
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 10:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007B6A011;
	Thu, 21 Dec 2023 10:52:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0107697A6;
	Thu, 21 Dec 2023 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24EA02F4;
	Thu, 21 Dec 2023 02:53:00 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61CF23F5A1;
	Thu, 21 Dec 2023 02:52:14 -0800 (PST)
Date: Thu, 21 Dec 2023 10:52:11 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Xinglong Yang <xinglong.yang@cixtech.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] firmware: arm_scmi: Check Mailbox/SMT channel for
 consistency
Message-ID: <ZYQY20PlVujcKB9H@bogus>
References: <20231220172112.763539-1-cristian.marussi@arm.com>
 <PUZPR06MB54988A8170D462FC8EE43A05F095A@PUZPR06MB5498.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR06MB54988A8170D462FC8EE43A05F095A@PUZPR06MB5498.apcprd06.prod.outlook.com>

On Thu, Dec 21, 2023 at 10:31:29AM +0000, Xinglong Yang wrote:
> Hi, Cristian
> 
> This patch successfully solves the bug.
>

I take this as:

Tested-by: Xinglong Yang <xinglong.yang@cixtech.com>

Please shout if you don't imply that.

-- 
Regards,
Sudeep

