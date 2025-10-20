Return-Path: <stable+bounces-188071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2779BF15A9
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2270404FE8
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCFC31280D;
	Mon, 20 Oct 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuU4OFAy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A631353A
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964794; cv=none; b=cuFn9EC/f+SpIZR0GyDLzA4lzR/QIh/SHXCCRlXwAY9ncjhZxBpTg87F9W9Uq3yPXBodSiXeo6XXgJvPpQHTqzMZk2Pk7QSOTWNEVRBCaEAX+Nhe9VOIN+v83rsbmzLoklYF6TuBxS9JDyOSFH4P4EdpGzinMT3xann2BAlHq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964794; c=relaxed/simple;
	bh=bABSDJ9gWFLRTJCKGjmrQRfAt5spbd9RSBNuy5L7ySc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZxSOSibQVUh2qgZwvfra4OawGhyAUH1hFH9EPYV7BTvlp8IW2O4qtnHVswKbhqN1J+9Tm9o4Xu/TVi274blaP2XlgBaf1j3N7rW/2zkwXXp36CTrYj750tSnugiBVBE6gHZ+1RJ5xMNgZHrWhwv1ZHnQt/g3cht8f0XwCCjfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuU4OFAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC94C113D0;
	Mon, 20 Oct 2025 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964794;
	bh=bABSDJ9gWFLRTJCKGjmrQRfAt5spbd9RSBNuy5L7ySc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YuU4OFAylYoN/Xl0uXa/Jby/4lvJfhty+7CsNauAfHCV6ODJe6eaw7aM/vHBxohcM
	 ZY7Tsd8xZ18DRFnXIpIvC8ugozJ11JL1NCXL7BdVbOHaKRTnfjSmP1pKpBMmowgjok
	 lbfqz8mM8zpFa2B+R557f8gpaBYnIHhPNqTQ0hgaNyzJNX155l88J1ivv4Xfqd3K/o
	 MHgfIprmiGgjYXjTCR/jQyib2a4N6i+S/4Ametn8oh/Kr8qLfbrJofVwVCZMOolmnZ
	 4hqGZb0tKmN+MMZ7dLUMlGhV8lX+PI7CZBYo39OCbdSeHL1uKBSpZD+2K05myZy+FT
	 iVgOU2QpCOFwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/7] [SEND COMMAND] Backport of d68886bae76a4b9b3484d23e5b7df086f940fa38 to 6.12.y
Date: Mon, 20 Oct 2025 08:53:05 -0400
Message-ID: <20251020125305.1760219-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125305.1760219-1-sashal@kernel.org>
References: <2025101657-preseason-garnish-c1e0@gregkh>
 <20251020125305.1760219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Send command:
git send-email --to stable@vger.kernel.org --in-reply-to '2025101657-preseason-garnish-c1e0@gregkh' --subject-prefix 'PATCH 6.12.y' stable/linux-6.12.y..HEAD
-- 
2.51.0


