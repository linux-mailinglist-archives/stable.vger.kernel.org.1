Return-Path: <stable+bounces-106582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BF19FEAD4
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 22:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECEEA7A15CC
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ED119ADA4;
	Mon, 30 Dec 2024 21:10:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753815E8B
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735593016; cv=none; b=e9C4cmIldryNkkv24zBhI6MNqEd+J8pzLJlW2dsNrd3Q7f7W7VAKPBkXVdMSj2AonLUHLm+iv5WNemVxAafnE87CAqTZ8layMuhqhFTXmyTgYL04Mk5LQStswROm4P6aov3IvxwC15M6KEGXT3QH8RG7ikz7lt3yq2FFgMxZ7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735593016; c=relaxed/simple;
	bh=18AbILU1gfGNne9TYIbLKighJn7ipy/fy41r6ZSO6V4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=b/a/zCdL6g+fUhv+nlEzBRLkYOel0CbjG1N8MLlPpbTckBLdofTatv5mlJF3nUvR9nrg/tBvPILjeZBlQfJLm5owWtZuS0pk3ShLj9ouufmAMVjqQfKnRlNOHlxbiASBS3a/mM+ScROKiwTWIjiehCRmb3IN0LQe7GuH78xN7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <cd99bc2f-6420-4415-8be7-de00de4742a2@gentoo.org>
Date: Mon, 30 Dec 2024 16:10:12 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mike Pagano <mpagano@gentoo.org>
Content-Language: en-US
To: stable@vger.kernel.org
Cc: wqu@suse.com
Subject: btrfs: lsblk multiple mount point issue on LTS 6.6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg,

A Gentoo user found an issue with btrfs where:

"... upstream commit a5d74fa24752
("btrfs: avoid unnecessary device path update for the same device") breaks
6.6 LTS kernel behavior where previously lsblk can properly show multiple
mount points of the same btrfs"

There's a revert on the bug report [1].
The fix by the author can be found on linux-btrfs [2]

[1] https://bugs.gentoo.org/947126
[2] https://lore.kernel.org/linux-btrfs/30aefd8b4e8c1f0c5051630b106a1ff3570d28ed.1735537399.git.wqu@suse.com/T/#u

Mike

-- 
Mike Pagano
Gentoo Developer - Kernel Project
E-Mail     : mpagano@gentoo.org
GnuPG FP   : 52CC A0B0 F631 0B17 0142 F83F 92A6 DBEC 81F2 B137
Public Key : http://pgp.mit.edu/pks/lookup?search=0x92A6DBEC81F2B137&op=index


