Return-Path: <stable+bounces-194889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E7CC61F51
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 01:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800E43B043C
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 00:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079B61448E0;
	Mon, 17 Nov 2025 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9oEb0us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8078747F
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763339811; cv=none; b=IhxlCw7qPQuyN+L9cKgKExEoZOZZQB7BSK/5MGyc6aUyr/8c4Hu+xyeJjDDR1giNLWEnbGZBbCr0PrOhaO8HcakcbHNItAuO30gU2jqDtE98HEY6Kk3Whssj631eay/mxU4KNH+Qxe2dWKmQP8xARnk4gC6+vKZxuIoi8VMuZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763339811; c=relaxed/simple;
	bh=iIFSeVu6g9WznJthnM4duAmh6H6pi7EcJE8Y60msibQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2q62KE0ObtrH8vlbiv8yKMQQgWvZ2M09nxrmMlZg3MxNCmuQNsYYlHPeG+6Ro9aOVxI7qIAtZlEWLtKIR4eTusHFbvht2p2K5P57UCGK2jpXQQkQn0aDn/CHWpGyuF9IGdotRKAxEl0girJLwQYDNpZsem1RuouGGgrTAtvxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9oEb0us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444C3C19423;
	Mon, 17 Nov 2025 00:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763339811;
	bh=iIFSeVu6g9WznJthnM4duAmh6H6pi7EcJE8Y60msibQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9oEb0us/OMjuX3spZZ79oFY6f3p9KJEP+krHGkmr0iHjJJiMw8iHnSmLWgS4EiXN
	 HLXKk3+XAo7Kr0fNK7KziEsrKRWoX9wwM/5LKqXMyU8gv5xbihryuy7IaCSrlWUh0Y
	 e/wcj1SvIdeznKZrIaZEQvNRsQDK0/qR4SoGkeZg/FqWRFuuD3jdS+eJ/6z+b8X5Ln
	 AkKr974Hs6YVJ5FU/CJ936k8lZLMWxKK74ECAEi3XdcYKncyJeWIXuaP1nl3syQPV7
	 P46PBqsynH8Dt9nBPn+w6iacvPNgx0Z/eHXHkcqfg7i4L6TvUjr9iUT4J0G2Dhqbmy
	 iiWDYekiZFBLg==
From: Sasha Levin <sashal@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: alexander.sverdlin@siemens.com,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: dsa: improve shutdown sequence
Date: Sun, 16 Nov 2025 19:36:48 -0500
Message-ID: <20251117003648.3733600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107031155.3026-1-681739313@139.com>
References: <20251107031155.3026-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: net: dsa: improve shutdown sequence

Thanks!

