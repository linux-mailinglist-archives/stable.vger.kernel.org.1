Return-Path: <stable+bounces-240098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDCCG5lC52no5QEAu9opvQ
	(envelope-from <stable+bounces-240098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79955438CDE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F493020AA6
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2680B3A1A5D;
	Tue, 21 Apr 2026 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWGB1ZqA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663BE39F162;
	Tue, 21 Apr 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763450; cv=none; b=XFkzwsoOgU1HJcnZKO5Da+0tViluTHP+PiiegmA2W3FVWsIJqVnmI255YP9dQr3GDjdZSPZbjy0tbmMgzstoehaxGRR9EO1Q7wJNmopdc16sfneK9VWzCb+9iWojrGHOLvFC8nRMbyXnkJIAk+yL/K40Ewuq+HT3o6lRG/P8Z/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763450; c=relaxed/simple;
	bh=z+h5Nnwo0xO4Chm3zN/QoyZZPeeIi/CZAFWRlbq4U+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhmPIe/YZyEC2wtiL61+iophNjcD3fXL3OyO+pYE1CU2eBAr+GqYpcpasYXB5PzbdoYfalT7fvHoZhe+TdKUGUkWWPM+UHKvEeDYGmlKC2ueNif1drs+o6+/wVQOoJ92HACJ2e4RdEA+fOLprsDS47mutluZlAAzkou0UJZT3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWGB1ZqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D54EC2BCB0;
	Tue, 21 Apr 2026 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776763449;
	bh=z+h5Nnwo0xO4Chm3zN/QoyZZPeeIi/CZAFWRlbq4U+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aWGB1ZqAhJB5fE0pCS22Z40rhlnNYtTfb1tpD6gC5YbQcAGPc80XmZq+aZbO6NkcM
	 DhO284RZmDJj+aj8PoJNrZOnPqRBBVaBf9x1WbbbEH5oUkUHvJYwd7BpnGrzEBQdJl
	 ul/WRlXC5lS0JYHVZ26J8dF6AbXvsK5VHj1FSnDhA4eHo59KzzlIja8YFZS4BU+4hb
	 etCY7cFsrX1/ZdZq+0KLT+zGe98Ss5FlChMU0awBBRD6BLb8y8qCMrLBxeKvmeGQSh
	 65MgdgNF4XM4QimOPWwcxARG6z0PQCIxy62KKSv06iezOY150UHR84092OivE5kwHT
	 3M0CyKhpGCWlA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Takahiro
 Kuwano <takahiro.kuwano@infineon.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Pratyush Yadav
 <p.yadav@ti.com>,  Michael Walle <michael@walle.cc>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in
 spi_nor_params_show()
In-Reply-To: <87jyu07olj.fsf@bootlin.com> (Miquel Raynal's message of "Tue, 21
	Apr 2026 09:35:20 +0200")
References: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
	<87jyu07olj.fsf@bootlin.com>
Date: Tue, 21 Apr 2026 09:24:05 +0000
Message-ID: <2vxz4il47jka.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240098-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 79955438CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21 2026, Miquel Raynal wrote:

> Hi Tudor,
>
> On 17/04/2026 at 15:24:39 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
>> Sashiko noticed an out-of-bounds read [1].
>
> [...]
>
>> Cc: stable@vger.kernel.org
>> Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via debugfs")
>> Closes: https://sashiko.dev/#/patchset/20260417-die-erase-fix-v2-1-73bb7004ebad%40infineon.com [1]
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>> We shall assign a CVE to this. I'll look into how next week.
>
> They are assigned automatically to every fix, no?
>
> If spi-nor folks want to ack, I might take it through an mtd/fixes PR.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Please do. Thanks!

-- 
Regards,
Pratyush Yadav

