Return-Path: <stable+bounces-12150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E0C8317FF
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 12:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93121C23B5A
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6CF24B25;
	Thu, 18 Jan 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bfALDnnh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C21774B;
	Thu, 18 Jan 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575750; cv=none; b=tm9JTkzsNAXuScvyNon5JN9e9d6h3/X/Sbt5b7Qt6n3jQjFZ5FEZpwCj4SIUrLmh32EhIBvjvvMojrJtzXTI1f+iyua8KUu/xY++x+ap0UjVwUO6wIRkTjR/Gupf26Q9gYKdz13xDJQjsb9lGww9EGYyTVqoAvidrmA7VzUOYqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575750; c=relaxed/simple;
	bh=dQCAJ85MB+Ou5E/5mmV3FPatQuBZNyv+xPlg1fbjEB4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=kxIa2Gj3L6J0ckDgaKn9dWKUJeLCJ/AYQnPXzpc/KlD0pCSQrY//7WbayrfyiCZF+cvS25KgJygAe9xewPvhgdhK4UX5MN79xQ+8h+anxm8EVV3ZjXpHO1ZFiTdxZ0UKeNtM6waRlNx3hPiBwTDYSGyANsSl3nokqUnzVRUsssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bfALDnnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38A6C43601;
	Thu, 18 Jan 2024 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575750;
	bh=dQCAJ85MB+Ou5E/5mmV3FPatQuBZNyv+xPlg1fbjEB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfALDnnhG1/ZqWgw1Oe3Osb2gV/jUjEaKzRniHlCCa6QVUbpVlAyRMSNFxAeKZLE6
	 7nw7FOoqxEnDAgj29U8+mFcRPaHdSTRQlFpYDRNvzhJa1SE1RCWSTxreKqIK7p+17F
	 Fg/+AYHSFsL/IP6Pdcw6ufKTMqdSVSKIG4baM7oM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 064/100] kselftest: alsa: fixed a print formatting warning
Date: Thu, 18 Jan 2024 11:49:12 +0100
Message-ID: <20240118104313.720966799@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
References: <20240118104310.892180084@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

[ Upstream commit 13d605e32e4cfdedcecdf3d98d21710ffe887708 ]

A statement used %d print formatter where %s should have
been used. The same has been fixed in this commit.

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Link: 5aaf9efffc57 ("kselftest: alsa: Add simplistic test for ALSA mixer controls kselftest")
Link: https://lore.kernel.org/r/20231217080019.1063476-1-ghanshyam1898@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index a38b89c28030..37da902545a4 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -177,7 +177,7 @@ static void find_controls(void)
 			err = snd_ctl_elem_info(card_data->handle,
 						ctl_data->info);
 			if (err < 0) {
-				ksft_print_msg("%s getting info for %d\n",
+				ksft_print_msg("%s getting info for %s\n",
 					       snd_strerror(err),
 					       ctl_data->name);
 			}
-- 
2.43.0




