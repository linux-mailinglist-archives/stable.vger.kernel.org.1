Return-Path: <stable+bounces-178879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE6CB489D8
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 12:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A11B23232
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA5F2EB848;
	Mon,  8 Sep 2025 10:17:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90F273F9;
	Mon,  8 Sep 2025 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326637; cv=none; b=HdgR1QGHymBaANRHofcPvFraAXAp8cMFRxn/cBp5XLPTqCGsE6YkS9YhWSISF/d2lnkupF7Dkumh69GhCfqRBjlg5pblDMtYCIndor8UuB5+LQKUDvQHfN6JZ2VDWh1/dMhsj6/d4Z9ciyV4oDA36m/kKLkXgf5jKV1nf4jZTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326637; c=relaxed/simple;
	bh=n/oQFG/OvGbaLMYw0ZsDdDOz/nP2ciICb18MBkVp4kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/UTjSY748tncba50n3KQH85mDy0Hgyh9nHLAk3i3Nip/ECbRCgAPogoS+a4kC6YxymbVjO8SUQXlbnHEEYYY76SAb01XU/uic871xV0jqv+KxZZO5P4qIs2vrX3qtFRH3pRG4lOvU8dB6LENfICLxCzz/IlNaE317Zwi2bIAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBBA61692;
	Mon,  8 Sep 2025 03:17:05 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DB973F66E;
	Mon,  8 Sep 2025 03:17:12 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: quirk: fix write to string constant
Date: Mon,  8 Sep 2025 11:17:06 +0100
Message-Id: <175732658793.3917221.3759858357141010136.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829132152.28218-1-johan@kernel.org>
References: <20250829132152.28218-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 29 Aug 2025 15:21:52 +0200, Johan Hovold wrote:
> The quirk version range is typically a string constant and must not be
> modified (e.g. as it may be stored in read-only memory):
> 
> 	Unable to handle kernel write to read-only memory at virtual
> 	address ffffc036d998a947
> 
> Fix the range parsing so that it operates on a copy of the version range
> string, and mark all the quirk strings as const to reduce the risk of
> introducing similar future issues.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: quirk: fix write to string constant
      https://git.kernel.org/sudeep.holla/c/572ce546390d
--
Regards,
Sudeep


