Return-Path: <stable+bounces-83227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 196CB996DB1
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8371C22914
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502211993B5;
	Wed,  9 Oct 2024 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axTSp+Dk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976417BB3E;
	Wed,  9 Oct 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484022; cv=none; b=tqzL/LzkfQdHxxYm5wrlCmbsT+Tuibp4X94v21rdMbZ/klxefxM+XslInBfBYOEv84KazlrNWhrTYKxainCRfn3DOT/LWgE+7SV0wZe6uP/bi4gukpj4oToEH8oH3hs+YvEzKuinupjX4EtR0ky6OgegZ5mMkgG83SgXjie/wcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484022; c=relaxed/simple;
	bh=MDSfxcpVBhXHa9uiPs3PHuImwK4ThD/0MyTFJwHnYjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=otYGJeAyAcMOYrc1jez1QsVrsUk8s+0j7i40QOIcZ+KxxJ3K9lYA9rmasOnyBlux5xZ1iLk79Vg62X5QAn/W4+4P2V/9zr1lwnOVpme0NcHhtFxsqBbpyqhimI5yAzg/bJgtsl6pYBtwqW3z6GCJqjkocEn4wOgtcMenxUGDlts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axTSp+Dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D78C4CEC3;
	Wed,  9 Oct 2024 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728484021;
	bh=MDSfxcpVBhXHa9uiPs3PHuImwK4ThD/0MyTFJwHnYjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=axTSp+DkY35Gsn5q0znUv1LTKuZI1MJ3qcF9cxSpQ4uEXy3JLAkBT8rGar8xv/92v
	 MuBNruaS3GoU+efAUDf8LHyO6lrs116EI/RaPzQinQfZDqlPfKNSjYfDMd0pow0DYq
	 scvXcYKnyD7I5EKAoY8xSDa0f2a/Qo3l1sEtp4/uMOuzeh+gyjCHJiGLzdPuRqPJqj
	 XjjLquOo3XC1pwIHRCfZsm2sVLbW9s4CxPVrMVV+9OC9gl3pDqbQMHi1TGGPkn3Voo
	 Xs/T9hR4GY64yzgITL+vK4poOhPvpB6xiI/vnyP7/g4A0uJPUFG6X0rHCqM2i97k/2
	 NW+fz1sv7ZknA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: W <linuxcdeveloper@gmail.com>, stable@vger.kernel.org, 
 linux-ide@vger.kernel.org
In-Reply-To: <20241008135843.1266244-2-cassel@kernel.org>
References: <20241008135843.1266244-2-cassel@kernel.org>
Subject: Re: [PATCH v2] ata: libata: avoid superfluous disk spin down +
 spin up during hibernation
Message-Id: <172848401972.1542808.12439348742745149573.b4-ty@kernel.org>
Date: Wed, 09 Oct 2024 16:26:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 08 Oct 2024 15:58:44 +0200, Niklas Cassel wrote:
> A user reported that commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi
> device manage_system_start_stop") introduced a spin down + immediate spin
> up of the disk both when entering and when resuming from hibernation.
> This behavior was not there before, and causes an increased latency both
> when when entering and when resuming from hibernation.
> 
> Hibernation is done by three consecutive PM events, in the following order:
> 1) PM_EVENT_FREEZE
> 2) PM_EVENT_THAW
> 3) PM_EVENT_HIBERNATE
> 
> [...]

Applied to libata/linux.git (for-6.12-fixes), thanks!

[1/1] ata: libata: avoid superfluous disk spin down + spin up during hibernation
      https://git.kernel.org/libata/linux/c/a38719e3

Kind regards,
Niklas


