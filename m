Return-Path: <stable+bounces-165698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABCBB1790E
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8719A3B03F0
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C057275B1D;
	Thu, 31 Jul 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biefKOWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143B265284
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000364; cv=none; b=Db9YTb4IyMAPw56HSKNlox4wjKN+C59/wc2tubwIVck/B+ZG+O2P3uAMvo2L1LBoT6QhboFSk7UfgyFzqZG4AOCPNjMwH3ih7GD4b7wTRaeJeV+vRbHilNp1YffItUYsWoHMBqfassKEPFO+3ugd2S8RSRIAuvd40TPSFUuGA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000364; c=relaxed/simple;
	bh=SObR5sqR1/YkaDYUbCxejICAHWLOpF3PyGmcK3g+wTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCggbKSf5ddaZwhonsPBCZF0Pb2PTdix8ZNQJOA/ckq6DBtWyRLvAVUYx7XG2JtgI0iImzt4+u5rMbWbfEUSrvbPgrRMfHdYQg1LQ3txpCs/yvwF2pX3E2r/7PzBylZ3urjXfGKXzLxclJb9hITjCQxbSgk6pzOtrLHyXd/6IC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biefKOWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF870C4CEEF;
	Thu, 31 Jul 2025 22:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754000363;
	bh=SObR5sqR1/YkaDYUbCxejICAHWLOpF3PyGmcK3g+wTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biefKOWlzuMzh7ej4E/AkyCZnk6bhnoECFhKPGS1cXJbIM4+xamwGarlh8C3Gzd5N
	 i3KRBRiKLgPFZ7SLt//Q9dv0N2KcDFS7zT+VuAZEjA/ABOMG1p4my7Qk8fdq4epWBX
	 AUQlB+DMn+7uGVndCoYWFnT5hxBcMEXFkBVYNX0QPT6cDAaXzCfRDDGRgPlrR85PJH
	 0mp0w18Vwan9kzXyr2Vc+SK8yNMRuALjs0stc+S+7p4XJIaC6hYjozIev2Oq6SgzSS
	 3oH9kMmb7VEFHYQGCsL0aDXbBIQjwScB+aibIRLXjU/lfdJuv7stCWieMtBrRMX8cO
	 iVwyIn2G4D1kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 6/6] mptcp: do not queue data on closed subflows
Date: Thu, 31 Jul 2025 18:19:21 -0400
Message-Id: <1753976295-3d4a3ac1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731112353.2638719-14-matttbe@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: c886d70286bf3ad411eb3d689328a67f7102c6ae

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Paolo Abeni <pabeni@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

