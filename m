Return-Path: <stable+bounces-197091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 464FFC8E48D
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B58C04E21DB
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC37231858;
	Thu, 27 Nov 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibhLL9/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFD1F12F8
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764247193; cv=none; b=IDj21LAJc1iC+AserFeO9zYGBwy9AhtoVL1UkiX4Gg84OhqxxjJ8rG7d/MJATBrtkrMlGHhU/dX5BRSh398xxeQD7muSrlko9stICh5682V7MeFrd791e2F4yI7iZkPlmp7Z0MpUNDc6BIQclA4dqxuN53Dio5RFcbvr7DbEHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764247193; c=relaxed/simple;
	bh=N/Lwjystm29fwD1vaZ9hJCsANFbcEGHSpAL+tHVp4Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8nOgTe0eKjhlLeMzO8FimrE8kVORM9Kol73fM0ijh7aJbxThnzVorPjConlae4W+k6qLng5lDK6z/Jco81OqnGOvUixK2aKFabsDlMjFXqusU8wTGKWIbNJFjreBRQHTRjuDrAArDXFouRph2oWTi9QV6hI9R43XcdqdNW74W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibhLL9/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F41C4CEF8;
	Thu, 27 Nov 2025 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764247192;
	bh=N/Lwjystm29fwD1vaZ9hJCsANFbcEGHSpAL+tHVp4Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibhLL9/vLDCkLhza0ciu6oq+YJgwIpGk/+wQRBm2UOvYU/qYFAOkmtbVERwLuZ/jX
	 vNeciD0eZphRJfo7Ir9oX27jdK9s1znyUO4tVYcqjKPQnWKf5z+evIoqO8nnL2ytgf
	 ArYHsY405HIYOsrCwrDVN9qtEoXj8mGzcfkl3XOMY8pwYx8pWV0wpFXyJ6YdBojXbQ
	 V+Rd5zrqlqLhlBSXuj3VX+kpUNsLwIEw5FOaXcVc6apOgdVEdfwZ49js+/lp6MpLQh
	 Rww+cquSFgPAvD0jSsbuYL5Qw5BS84EnQSfX3YnL9HPIMX06MbtN11kGVCxnUZ2FyU
	 /lze+cFLAtjVQ==
From: Sasha Levin <sashal@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: stable@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Thu, 27 Nov 2025 07:39:50 -0500
Message-ID: <20251127123950.1635014-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121135057.1062568-1-kas@kernel.org>
References: <20251121135057.1062568-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.1 stable tree.

Subject: filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Queue: 6.1

Thanks for the backport!

