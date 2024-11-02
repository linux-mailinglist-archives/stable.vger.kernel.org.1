Return-Path: <stable+bounces-89546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D59B9C6F
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 04:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C12E1F229C3
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 03:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD4E146D6B;
	Sat,  2 Nov 2024 03:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfHTBOcv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA850146A9B
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730516623; cv=none; b=CiIi449DD9UYnH2knWqgcm5x9RD4ipvbMfcDLzSqDaVQ/2xgrfvtrreswISDGFK0GYDuuQd0JASsSVtZSAXYL4q4f+BNx+YVuK7rAAttlZWReFuKudcN6qL7EP3Issz0o8ki7kql48lqDcT+5r4njocLo1AcfQE0J0knukOpUoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730516623; c=relaxed/simple;
	bh=d2yRXSESl+Ba+LY6ivTIlaaO9WstofUVh8XYi9dMtAE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dDTqlShEc/HlijMYtAOJV/ygg7eFnpI86DiCPkDBuV9eFi8pMXCOD60blCtRorCHH6I9Vuc2vIKs8RdQUUWp6cL1CMUrvAxFZ0XESytCvzzE2PMv4IwQHsxq+2RFhXXwrtCI+FQNZrtLvMt9NSZ7AlVrvNfuyT74Uj+TDGmsKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfHTBOcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269C0C4CECD
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 03:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730516622;
	bh=d2yRXSESl+Ba+LY6ivTIlaaO9WstofUVh8XYi9dMtAE=;
	h=Date:To:From:Subject:From;
	b=AfHTBOcvUloonWy2e9kXG8WJWSRJfJEk2vv3xdWHl6vfgu5FngF2Af1Qsg0uA7BXF
	 kUzCt/hwgHtxNxCFJj4dRLgZ38WPgFxdBvcAsAgZ1Q7oAxl2Y80mTzd9IF/g6msWrK
	 MazlI2BciE5w8rc3xSI3JakEiHO2Sx1vOVgVobUD/pQD3cS/qVHzbevg/Wc+b6oxbi
	 S/oN7t2vrf4dAr80coaRnZbAb66ioC0CX7Fo/Xi0y4tntMgupDm94MNr2W22uYhGIT
	 Q5oPVKt+Z4hz49Vl8eephnQfS9jQWOCOU2EZVEflfQ67FYbw7y7x0iHftVQZS9GhkF
	 iwsWtDtvFmfeg==
Message-ID: <94581271-d8f2-4c4a-8a62-961b78941f9a@kernel.org>
Date: Fri, 1 Nov 2024 22:03:40 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Mario Limonciello <superm1@kernel.org>
Subject: Default profile performance issue on Navi 3x
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

A performance issue on AMD Navi3x dGPUs in 6.10.y and 6.11.y has been 
improved by patches that landed in 6.12-rc.

Can you please bring these 3 patches back to 6.11.y to help performance 
there as well?

commit b932d5ad9257 ("drm/amdgpu/swsmu: fix ordering for setting 
workload_mask")
commit ec1aab7816b0 ("drm/amdgpu/swsmu: default to fullscreen 3D profile 
for dGPUs")
commit 7c210ca5a2d7 ("drm/amdgpu: handle default profile on on devices 
without fullscreen 3D")

Thanks!


