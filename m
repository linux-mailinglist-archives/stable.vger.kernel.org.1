Return-Path: <stable+bounces-203085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C554CD0003
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 14:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F92A30C334D
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D1532572D;
	Fri, 19 Dec 2025 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MvJIItnU"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1F325716
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149444; cv=none; b=FiX6v1rt0Gz9ma9i8b4ElFvS2yHLBjvfbIe09JLU3Y2gE2RJDyWEb7QXa7CVyaTDdX/mR6zEGeOGcrcZ20KN7lyFNKkJPEAbtGVhCON71Iwd7AMiNLUG/2qbyJ68fsX9Eh20+UDYXEY0HdH3h+wshgPjmWnOMZ8RMk7MSPOmkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149444; c=relaxed/simple;
	bh=Iml+BOzB8itHmy1wmzCJMarP4nhjL9hrlRJNdNtfPdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZft/u2PgkNCJ1x7/Zl90BZBwMNjtcuLpjh4JQ6m+N+YnjIHHJnt4uth9zQT6Sa8PlJFvRly5Ky6bSdbIVMxrgnELqk3dQLGAoYdezVJ5/xxFD5zfZT0E/5ck9VZ5Gc8LmpGsNT7w6563aXkcgJPwongb7Tnx3ejRlehX2ezVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MvJIItnU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1766149439;
	bh=Iml+BOzB8itHmy1wmzCJMarP4nhjL9hrlRJNdNtfPdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MvJIItnUqfLCkNBxP9g14nWqbwg/PDtQORAB1wus+Q15Od5tRJybB6k177PHEAqzL
	 opgage7mSkCZiYoksrYmyKuRdEsqrfBTv1a3CL5WTftWoHB6F1eioTtk7XQT5QLrDS
	 4EBJYV9QU0UyCns3ypDLrbZnToawTKn+F33KoJbLDYE5TOxW333GmYZinyeeAohz90
	 vyQozwrZC6GyY+YEge9Rf1QISwxQxg0HbfjzQKNsDsmQaUZs4NdpG5fhv82POZLL9E
	 glu6dPsN4RwsOJjJT5AkAmOvDLzdvr6vC1W530amBsNwwGjerNWHZKUV+tQKcGnM0M
	 w0GyspAWKH3/A==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1EBDF17E0465;
	Fri, 19 Dec 2025 14:03:59 +0100 (CET)
Date: Fri, 19 Dec 2025 14:03:55 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dmitry.osipenko@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/tests: shmem: Swap names of export tests
Message-ID: <20251219140355.27212b9b@fedora>
In-Reply-To: <20251212160317.287409-2-tzimmermann@suse.de>
References: <20251212160317.287409-1-tzimmermann@suse.de>
	<20251212160317.287409-2-tzimmermann@suse.de>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 17:00:32 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> GEM SHMEM has 2 helpers for exporting S/G tables. Swap the names of
> the rsp. tests, so that each matches the helper it tests.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/tests/drm_gem_shmem_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> index 68f2c3162354..872881ec9c30 100644
> --- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> +++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
> @@ -194,7 +194,7 @@ static void drm_gem_shmem_test_vmap(struct kunit *test)
>   * scatter/gather table large enough to accommodate the backing memory
>   * is successfully exported.
>   */
> -static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
> +static void drm_gem_shmem_test_get_sg_table(struct kunit *test)
>  {
>  	struct drm_device *drm_dev = test->priv;
>  	struct drm_gem_shmem_object *shmem;
> @@ -236,7 +236,7 @@ static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
>   * backing pages are pinned and a scatter/gather table large enough to
>   * accommodate the backing memory is successfully exported.
>   */
> -static void drm_gem_shmem_test_get_sg_table(struct kunit *test)
> +static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
>  {
>  	struct drm_device *drm_dev = test->priv;
>  	struct drm_gem_shmem_object *shmem;
> @@ -366,8 +366,8 @@ static struct kunit_case drm_gem_shmem_test_cases[] = {
>  	KUNIT_CASE(drm_gem_shmem_test_obj_create_private),
>  	KUNIT_CASE(drm_gem_shmem_test_pin_pages),
>  	KUNIT_CASE(drm_gem_shmem_test_vmap),
> -	KUNIT_CASE(drm_gem_shmem_test_get_pages_sgt),
>  	KUNIT_CASE(drm_gem_shmem_test_get_sg_table),
> +	KUNIT_CASE(drm_gem_shmem_test_get_pages_sgt),
>  	KUNIT_CASE(drm_gem_shmem_test_madvise),
>  	KUNIT_CASE(drm_gem_shmem_test_purge),
>  	{}


