Return-Path: <stable+bounces-244126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIFmBlbj+WmlEwMAu9opvQ
	(envelope-from <stable+bounces-244126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:32:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EDE4CD8EB
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD59730FF4D6
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2170426EC0;
	Tue,  5 May 2026 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN33F7mM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61733ADA4;
	Tue,  5 May 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984015; cv=none; b=oqk8ki88PSRkytLB7scJQSU5b/oBpX/ot2glC2yDiFjmWPq1MPixfMPjAby+3aEtSIRK2HkXRXjamRi9sm7X+Wveuv893Qj7qkEBymotXt0h+yQ2lJAFlwqNdZA4VMmtmMRLpWIsQxwuXvati7oA4fLg5pVIc/nd+S8PBxoG2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984015; c=relaxed/simple;
	bh=kTA55tKuy23MozNyDWkXQMbFnH6JyYys6X0NlNT+Sfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6HZcC6GFdzc9Mwjwp81KHYzO+KsVU116uAeNVzsDLNkSN6gCEV+kK1wnVT4t6PQSX4w4f/vNeqnqcLGpzgm7ZI13sS8mU+w8drvS2A+JX2RIB3YLpLuOEUdAku+Os+Mh9fdi5+An32qjFL6RQP9+Q+m2vD0EpVj/LSM4ZelS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN33F7mM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777984012; x=1809520012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kTA55tKuy23MozNyDWkXQMbFnH6JyYys6X0NlNT+Sfc=;
  b=AN33F7mMQhT76pnR5fUY5M/ndQWD7PeLLkt8ybaHWGE+pqbmyvGrona/
   K169w69P5u+eAIDHSlkX1kYbiW7mYTRYE1P5bMITaMNIh5bMpMAYfP1jA
   UEIk3ekmEioflVTs1JNpPy2X/pjvAPqfhLgBDQ91fU4DRGlMKwURQETr+
   P7LMwuYsc8CFRnxqS8xNkd1lgku+zhl4zefRgbQtPVlHYiNbbLZ4U5Vl3
   RX91fmGnmiki0wevEBqCMYwFLqpo8aJtbxqs2Rw1+QO1tGdb9fMSMEjiN
   LzMjK0jbpX0f1vYKXJPA5mX263TRBFLwvpXm4TWFTAKgQIs4rvyvQGJ3a
   Q==;
X-CSE-ConnectionGUID: 3PE5379TTC6DWK3Vs/+3XQ==
X-CSE-MsgGUID: i9/iEjBUSJ2jdiro2yWZnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78559244"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78559244"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:26:52 -0700
X-CSE-ConnectionGUID: qT+/MYAKQzigpcTIQHkgbw==
X-CSE-MsgGUID: ixtMUqKjQZu0m73LOr0rDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="229315708"
Received: from lkp-server01.sh.intel.com (HELO 9ec114424ce8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 05 May 2026 05:26:49 -0700
Received: from kbuild by 9ec114424ce8 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKErP-0000000007p-0DDY;
	Tue, 05 May 2026 12:26:47 +0000
Date: Tue, 5 May 2026 20:26:19 +0800
From: kernel test robot <lkp@intel.com>
To: Pavitra Jha <jhapavitra98@gmail.com>,
	almaz.alexandrovich@paragon-software.com
Cc: oe-kbuild-all@lists.linux.dev, ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	Pavitra Jha <jhapavitra98@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: fix Out-Of-Bounds write in log_replay() via
 unvalidated data_off
Message-ID: <202605052042.LmYa1Y0L-lkp@intel.com>
References: <20260502105008.21827-1-jhapavitra98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502105008.21827-1-jhapavitra98@gmail.com>
X-Rspamd-Queue-Id: 85EDE4CD8EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linuxfoundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244126-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,paragon-software.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid]

Hi Pavitra,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v7.1-rc2 next-20260504]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pavitra-Jha/fs-ntfs3-fix-Out-Of-Bounds-write-in-log_replay-via-unvalidated-data_off/20260505-085836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260502105008.21827-1-jhapavitra98%40gmail.com
patch subject: [PATCH] fs/ntfs3: fix Out-Of-Bounds write in log_replay() via unvalidated data_off
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20260505/202605052042.LmYa1Y0L-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260505/202605052042.LmYa1Y0L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605052042.LmYa1Y0L-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ntfs3/fslog.c: In function 'do_action':
>> fs/ntfs3/fslog.c:3490:21: error: implicit declaration of function 'ntfs3_bad_de_range' [-Wimplicit-function-declaration]
    3490 |                 if (ntfs3_bad_de_range(e, dlen))
         |                     ^~~~~~~~~~~~~~~~~~


vim +/ntfs3_bad_de_range +3490 fs/ntfs3/fslog.c

  3052	
  3053	/*
  3054	 * do_action - Common routine for the Redo and Undo Passes.
  3055	 * @rlsn: If it is NULL then undo.
  3056	 */
  3057	static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
  3058			     const struct LOG_REC_HDR *lrh, u32 op, void *data,
  3059			     u32 dlen, u32 rec_len, const u64 *rlsn)
  3060	{
  3061		int err = 0;
  3062		struct ntfs_sb_info *sbi = log->ni->mi.sbi;
  3063		struct inode *inode = NULL, *inode_parent;
  3064		struct mft_inode *mi = NULL, *mi2_child = NULL;
  3065		CLST rno = 0, rno_base = 0;
  3066		struct INDEX_BUFFER *ib = NULL;
  3067		struct MFT_REC *rec = NULL;
  3068		struct ATTRIB *attr = NULL, *attr2;
  3069		struct INDEX_HDR *hdr;
  3070		struct INDEX_ROOT *root;
  3071		struct NTFS_DE *e, *e1, *e2;
  3072		struct NEW_ATTRIBUTE_SIZES *new_sz;
  3073		struct ATTR_FILE_NAME *fname;
  3074		struct OpenAttr *oa, *oa2;
  3075		u32 nsize, t32, asize, used, esize, off, bits;
  3076		u16 id, id2;
  3077		u32 record_size = sbi->record_size;
  3078		u64 t64;
  3079		u16 roff = le16_to_cpu(lrh->record_off);
  3080		u16 aoff = le16_to_cpu(lrh->attr_off);
  3081		u64 lco = 0;
  3082		u64 cbo = (u64)le16_to_cpu(lrh->cluster_off) << SECTOR_SHIFT;
  3083		u64 tvo = le64_to_cpu(lrh->target_vcn) << sbi->cluster_bits;
  3084		u64 vbo = cbo + tvo;
  3085		void *buffer_le = NULL;
  3086		u32 bytes = 0;
  3087		bool a_dirty = false;
  3088		u16 data_off;
  3089	
  3090		oa = oe->ptr;
  3091	
  3092		/* Big switch to prepare. */
  3093		switch (op) {
  3094		/* ============================================================
  3095		 * Process MFT records, as described by the current log record.
  3096		 * ============================================================
  3097		 */
  3098		case InitializeFileRecordSegment:
  3099		case DeallocateFileRecordSegment:
  3100		case WriteEndOfFileRecordSegment:
  3101		case CreateAttribute:
  3102		case DeleteAttribute:
  3103		case UpdateResidentValue:
  3104		case UpdateMappingPairs:
  3105		case SetNewAttributeSizes:
  3106		case AddIndexEntryRoot:
  3107		case DeleteIndexEntryRoot:
  3108		case SetIndexEntryVcnRoot:
  3109		case UpdateFileNameRoot:
  3110		case UpdateRecordDataRoot:
  3111		case ZeroEndOfFileRecord:
  3112			rno = vbo >> sbi->record_bits;
  3113			inode = ilookup(sbi->sb, rno);
  3114			if (inode) {
  3115				mi = &ntfs_i(inode)->mi;
  3116			} else {
  3117				/* Read from disk. */
  3118				err = mi_get(sbi, rno, &mi);
  3119				if (err && op == InitializeFileRecordSegment) {
  3120					mi = kzalloc_obj(struct mft_inode, GFP_NOFS);
  3121					if (!mi)
  3122						return -ENOMEM;
  3123					err = mi_format_new(mi, sbi, rno, 0, false);
  3124				}
  3125				if (err)
  3126					return err;
  3127			}
  3128			rec = mi->mrec;
  3129	
  3130			if (op == DeallocateFileRecordSegment)
  3131				goto skip_load_parent;
  3132	
  3133			if (rec->rhdr.sign == NTFS_BAAD_SIGNATURE)
  3134				goto dirty_vol;
  3135			if (!check_lsn(&rec->rhdr, rlsn))
  3136				goto out;
  3137			if (!check_file_record(rec, NULL, sbi))
  3138				goto dirty_vol;
  3139			attr = Add2Ptr(rec, roff);
  3140	
  3141			if (is_rec_base(rec) || InitializeFileRecordSegment == op) {
  3142				rno_base = rno;
  3143				goto skip_load_parent;
  3144			}
  3145	
  3146			rno_base = ino_get(&rec->parent_ref);
  3147			inode_parent = ntfs_iget5(sbi->sb, &rec->parent_ref, NULL);
  3148			if (IS_ERR(inode_parent))
  3149				goto skip_load_parent;
  3150	
  3151			if (is_bad_inode(inode_parent)) {
  3152				iput(inode_parent);
  3153				goto skip_load_parent;
  3154			}
  3155	
  3156			if (ni_load_mi_ex(ntfs_i(inode_parent), rno, &mi2_child)) {
  3157				iput(inode_parent);
  3158			} else {
  3159				if (mi2_child->mrec != mi->mrec)
  3160					memcpy(mi2_child->mrec, mi->mrec,
  3161					       sbi->record_size);
  3162	
  3163				if (inode)
  3164					iput(inode);
  3165				else
  3166					mi_put(mi);
  3167	
  3168				inode = inode_parent;
  3169				mi = mi2_child;
  3170				rec = mi2_child->mrec;
  3171				attr = Add2Ptr(rec, roff);
  3172			}
  3173	
  3174	skip_load_parent:
  3175			inode_parent = NULL;
  3176			break;
  3177	
  3178		/*
  3179		 * Process attributes, as described by the current log record.
  3180		 */
  3181		case UpdateNonresidentValue:
  3182		case AddIndexEntryAllocation:
  3183		case DeleteIndexEntryAllocation:
  3184		case WriteEndOfIndexBuffer:
  3185		case SetIndexEntryVcnAllocation:
  3186		case UpdateFileNameAllocation:
  3187		case SetBitsInNonresidentBitMap:
  3188		case ClearBitsInNonresidentBitMap:
  3189		case UpdateRecordDataAllocation:
  3190			attr = oa->attr;
  3191			bytes = UpdateNonresidentValue == op ? dlen : 0;
  3192			lco = (u64)le16_to_cpu(lrh->lcns_follow) << sbi->cluster_bits;
  3193	
  3194			if (attr->type == ATTR_ALLOC) {
  3195				t32 = le32_to_cpu(oe->bytes_per_index);
  3196				if (bytes < t32)
  3197					bytes = t32;
  3198			}
  3199	
  3200			if (!bytes)
  3201				bytes = lco - cbo;
  3202	
  3203			bytes += roff;
  3204			if (attr->type == ATTR_ALLOC)
  3205				bytes = (bytes + 511) & ~511; // align
  3206	
  3207			buffer_le = kmalloc(bytes, GFP_NOFS);
  3208			if (!buffer_le)
  3209				return -ENOMEM;
  3210	
  3211			err = ntfs_read_run_nb(sbi, oa->run1, vbo, buffer_le, bytes,
  3212					       NULL);
  3213			if (err)
  3214				goto out;
  3215	
  3216			if (attr->type == ATTR_ALLOC && *(int *)buffer_le)
  3217				ntfs_fix_post_read(buffer_le, bytes, false);
  3218			break;
  3219	
  3220		default:
  3221			WARN_ON(1);
  3222		}
  3223	
  3224		/* Big switch to do operation. */
  3225		switch (op) {
  3226		case InitializeFileRecordSegment:
  3227			if (roff + dlen > record_size)
  3228				goto dirty_vol;
  3229	
  3230			memcpy(Add2Ptr(rec, roff), data, dlen);
  3231			mi->dirty = true;
  3232			break;
  3233	
  3234		case DeallocateFileRecordSegment:
  3235			clear_rec_inuse(rec);
  3236			le16_add_cpu(&rec->seq, 1);
  3237			mi->dirty = true;
  3238			break;
  3239	
  3240		case WriteEndOfFileRecordSegment:
  3241			attr2 = (struct ATTRIB *)data;
  3242			if (!check_if_attr(rec, lrh) || roff + dlen > record_size)
  3243				goto dirty_vol;
  3244	
  3245			memmove(attr, attr2, dlen);
  3246			rec->used = cpu_to_le32(ALIGN(roff + dlen, 8));
  3247	
  3248			mi->dirty = true;
  3249			break;
  3250	
  3251		case CreateAttribute:
  3252			attr2 = (struct ATTRIB *)data;
  3253			asize = le32_to_cpu(attr2->size);
  3254			used = le32_to_cpu(rec->used);
  3255	
  3256			if (!check_if_attr(rec, lrh) || dlen < SIZEOF_RESIDENT ||
  3257			    !IS_ALIGNED(asize, 8) ||
  3258			    Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len) ||
  3259			    dlen > record_size - used) {
  3260				goto dirty_vol;
  3261			}
  3262	
  3263			memmove(Add2Ptr(attr, asize), attr, used - roff);
  3264			memcpy(attr, attr2, asize);
  3265	
  3266			rec->used = cpu_to_le32(used + asize);
  3267			id = le16_to_cpu(rec->next_attr_id);
  3268			id2 = le16_to_cpu(attr2->id);
  3269			if (id <= id2)
  3270				rec->next_attr_id = cpu_to_le16(id2 + 1);
  3271			if (is_attr_indexed(attr))
  3272				le16_add_cpu(&rec->hard_links, 1);
  3273	
  3274			oa2 = find_loaded_attr(log, attr, rno_base);
  3275			if (oa2)
  3276				update_oa_attr(oa2, attr);
  3277	
  3278			mi->dirty = true;
  3279			break;
  3280	
  3281		case DeleteAttribute:
  3282			asize = le32_to_cpu(attr->size);
  3283			used = le32_to_cpu(rec->used);
  3284	
  3285			if (!check_if_attr(rec, lrh))
  3286				goto dirty_vol;
  3287	
  3288			rec->used = cpu_to_le32(used - asize);
  3289			if (is_attr_indexed(attr))
  3290				le16_add_cpu(&rec->hard_links, -1);
  3291	
  3292			memmove(attr, Add2Ptr(attr, asize), used - asize - roff);
  3293	
  3294			mi->dirty = true;
  3295			break;
  3296	
  3297		case UpdateResidentValue:
  3298			nsize = aoff + dlen;
  3299	
  3300			if (!check_if_attr(rec, lrh))
  3301				goto dirty_vol;
  3302	
  3303			asize = le32_to_cpu(attr->size);
  3304			used = le32_to_cpu(rec->used);
  3305	
  3306			if (lrh->redo_len == lrh->undo_len) {
  3307				if (nsize > asize)
  3308					goto dirty_vol;
  3309				goto move_data;
  3310			}
  3311	
  3312			if (nsize > asize && nsize - asize > record_size - used)
  3313				goto dirty_vol;
  3314	
  3315			nsize = ALIGN(nsize, 8);
  3316			data_off = le16_to_cpu(attr->res.data_off);
  3317	
  3318			if (nsize < asize) {
  3319				memmove(Add2Ptr(attr, aoff), data, dlen);
  3320				data = NULL; // To skip below memmove().
  3321			}
  3322	
  3323			memmove(Add2Ptr(attr, nsize), Add2Ptr(attr, asize),
  3324				used - le16_to_cpu(lrh->record_off) - asize);
  3325	
  3326			rec->used = cpu_to_le32(used + nsize - asize);
  3327			attr->size = cpu_to_le32(nsize);
  3328			attr->res.data_size = cpu_to_le32(aoff + dlen - data_off);
  3329	
  3330	move_data:
  3331			if (data)
  3332				memmove(Add2Ptr(attr, aoff), data, dlen);
  3333	
  3334			oa2 = find_loaded_attr(log, attr, rno_base);
  3335			if (oa2 && update_oa_attr(oa2, attr))
  3336				oa2->run1 = &oa2->run0;
  3337	
  3338			mi->dirty = true;
  3339			break;
  3340	
  3341		case UpdateMappingPairs:
  3342			nsize = aoff + dlen;
  3343			asize = le32_to_cpu(attr->size);
  3344			used = le32_to_cpu(rec->used);
  3345	
  3346			if (!check_if_attr(rec, lrh) || !attr->non_res ||
  3347			    aoff < le16_to_cpu(attr->nres.run_off) || aoff > asize ||
  3348			    (nsize > asize && nsize - asize > record_size - used)) {
  3349				goto dirty_vol;
  3350			}
  3351	
  3352			nsize = ALIGN(nsize, 8);
  3353	
  3354			memmove(Add2Ptr(attr, nsize), Add2Ptr(attr, asize),
  3355				used - le16_to_cpu(lrh->record_off) - asize);
  3356			rec->used = cpu_to_le32(used + nsize - asize);
  3357			attr->size = cpu_to_le32(nsize);
  3358			memmove(Add2Ptr(attr, aoff), data, dlen);
  3359	
  3360			if (run_get_highest_vcn(le64_to_cpu(attr->nres.svcn),
  3361						attr_run(attr), &t64)) {
  3362				goto dirty_vol;
  3363			}
  3364	
  3365			attr->nres.evcn = cpu_to_le64(t64);
  3366			oa2 = find_loaded_attr(log, attr, rno_base);
  3367			if (oa2 && oa2->attr->non_res)
  3368				oa2->attr->nres.evcn = attr->nres.evcn;
  3369	
  3370			mi->dirty = true;
  3371			break;
  3372	
  3373		case SetNewAttributeSizes:
  3374			new_sz = data;
  3375			if (!check_if_attr(rec, lrh) || !attr->non_res)
  3376				goto dirty_vol;
  3377	
  3378			attr->nres.alloc_size = new_sz->alloc_size;
  3379			attr->nres.data_size = new_sz->data_size;
  3380			attr->nres.valid_size = new_sz->valid_size;
  3381	
  3382			if (dlen >= sizeof(struct NEW_ATTRIBUTE_SIZES))
  3383				attr->nres.total_size = new_sz->total_size;
  3384	
  3385			oa2 = find_loaded_attr(log, attr, rno_base);
  3386			if (oa2)
  3387				update_oa_attr(oa2, attr);
  3388	
  3389			mi->dirty = true;
  3390			break;
  3391	
  3392		case AddIndexEntryRoot:
  3393			e = (struct NTFS_DE *)data;
  3394			esize = le16_to_cpu(e->size);
  3395			root = resident_data(attr);
  3396			hdr = &root->ihdr;
  3397			used = le32_to_cpu(hdr->used);
  3398	
  3399			if (!check_if_index_root(rec, lrh) ||
  3400			    !check_if_root_index(attr, hdr, lrh) ||
  3401			    Add2Ptr(data, esize) > Add2Ptr(lrh, rec_len) ||
  3402			    esize > le32_to_cpu(rec->total) - le32_to_cpu(rec->used)) {
  3403				goto dirty_vol;
  3404			}
  3405	
  3406			e1 = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
  3407	
  3408			change_attr_size(rec, attr, le32_to_cpu(attr->size) + esize);
  3409	
  3410			memmove(Add2Ptr(e1, esize), e1,
  3411				PtrOffset(e1, Add2Ptr(hdr, used)));
  3412			memmove(e1, e, esize);
  3413	
  3414			le32_add_cpu(&attr->res.data_size, esize);
  3415			hdr->used = cpu_to_le32(used + esize);
  3416			le32_add_cpu(&hdr->total, esize);
  3417	
  3418			mi->dirty = true;
  3419			break;
  3420	
  3421		case DeleteIndexEntryRoot:
  3422			root = resident_data(attr);
  3423			hdr = &root->ihdr;
  3424			used = le32_to_cpu(hdr->used);
  3425	
  3426			if (!check_if_index_root(rec, lrh) ||
  3427			    !check_if_root_index(attr, hdr, lrh)) {
  3428				goto dirty_vol;
  3429			}
  3430	
  3431			e1 = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
  3432			esize = le16_to_cpu(e1->size);
  3433			if (PtrOffset(e1, Add2Ptr(hdr, used)) < esize)
  3434				goto dirty_vol;
  3435	
  3436			e2 = Add2Ptr(e1, esize);
  3437	
  3438			memmove(e1, e2, PtrOffset(e2, Add2Ptr(hdr, used)));
  3439	
  3440			le32_sub_cpu(&attr->res.data_size, esize);
  3441			hdr->used = cpu_to_le32(used - esize);
  3442			le32_sub_cpu(&hdr->total, esize);
  3443	
  3444			change_attr_size(rec, attr, le32_to_cpu(attr->size) - esize);
  3445	
  3446			mi->dirty = true;
  3447			break;
  3448	
  3449		case SetIndexEntryVcnRoot:
  3450			root = resident_data(attr);
  3451			hdr = &root->ihdr;
  3452	
  3453			if (!check_if_index_root(rec, lrh) ||
  3454			    !check_if_root_index(attr, hdr, lrh)) {
  3455				goto dirty_vol;
  3456			}
  3457	
  3458			e = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
  3459	
  3460			de_set_vbn_le(e, *(__le64 *)data);
  3461			mi->dirty = true;
  3462			break;
  3463	
  3464		case UpdateFileNameRoot:
  3465			root = resident_data(attr);
  3466			hdr = &root->ihdr;
  3467	
  3468			if (!check_if_index_root(rec, lrh) ||
  3469			    !check_if_root_index(attr, hdr, lrh)) {
  3470				goto dirty_vol;
  3471			}
  3472	
  3473			e = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
  3474			fname = (struct ATTR_FILE_NAME *)(e + 1);
  3475			memmove(&fname->dup, data, sizeof(fname->dup)); //
  3476			mi->dirty = true;
  3477			break;
  3478	
  3479		case UpdateRecordDataRoot:
  3480			root = resident_data(attr);
  3481			hdr = &root->ihdr;
  3482	
  3483			if (!check_if_index_root(rec, lrh) ||
  3484			    !check_if_root_index(attr, hdr, lrh)) {
  3485				goto dirty_vol;
  3486			}
  3487	
  3488			e = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
  3489	
> 3490			if (ntfs3_bad_de_range(e, dlen))
  3491				goto dirty_vol;
  3492	
  3493			memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
  3494	
  3495			mi->dirty = true;
  3496			break;
  3497	
  3498		case ZeroEndOfFileRecord:
  3499			if (roff + dlen > record_size)
  3500				goto dirty_vol;
  3501	
  3502			memset(attr, 0, dlen);
  3503			mi->dirty = true;
  3504			break;
  3505	
  3506		case UpdateNonresidentValue:
  3507			if (lco < cbo + roff + dlen)
  3508				goto dirty_vol;
  3509	
  3510			memcpy(Add2Ptr(buffer_le, roff), data, dlen);
  3511	
  3512			a_dirty = true;
  3513			if (attr->type == ATTR_ALLOC)
  3514				ntfs_fix_pre_write(buffer_le, bytes);
  3515			break;
  3516	
  3517		case AddIndexEntryAllocation:
  3518			ib = Add2Ptr(buffer_le, roff);
  3519			hdr = &ib->ihdr;
  3520			e = data;
  3521			esize = le16_to_cpu(e->size);
  3522			e1 = Add2Ptr(ib, aoff);
  3523	
  3524			if (is_baad(&ib->rhdr))
  3525				goto dirty_vol;
  3526			if (!check_lsn(&ib->rhdr, rlsn))
  3527				goto out;
  3528	
  3529			used = le32_to_cpu(hdr->used);
  3530	
  3531			if (!check_index_buffer(ib, bytes) ||
  3532			    !check_if_alloc_index(hdr, aoff) ||
  3533			    Add2Ptr(e, esize) > Add2Ptr(lrh, rec_len) ||
  3534			    used + esize > le32_to_cpu(hdr->total)) {
  3535				goto dirty_vol;
  3536			}
  3537	
  3538			memmove(Add2Ptr(e1, esize), e1,
  3539				PtrOffset(e1, Add2Ptr(hdr, used)));
  3540			memcpy(e1, e, esize);
  3541	
  3542			hdr->used = cpu_to_le32(used + esize);
  3543	
  3544			a_dirty = true;
  3545	
  3546			ntfs_fix_pre_write(&ib->rhdr, bytes);
  3547			break;
  3548	
  3549		case DeleteIndexEntryAllocation:
  3550			ib = Add2Ptr(buffer_le, roff);
  3551			hdr = &ib->ihdr;
  3552			e = Add2Ptr(ib, aoff);
  3553			esize = le16_to_cpu(e->size);
  3554	
  3555			if (is_baad(&ib->rhdr))
  3556				goto dirty_vol;
  3557			if (!check_lsn(&ib->rhdr, rlsn))
  3558				goto out;
  3559	
  3560			if (!check_index_buffer(ib, bytes) ||
  3561			    !check_if_alloc_index(hdr, aoff)) {
  3562				goto dirty_vol;
  3563			}
  3564	
  3565			e1 = Add2Ptr(e, esize);
  3566			nsize = esize;
  3567			used = le32_to_cpu(hdr->used);
  3568	
  3569			memmove(e, e1, PtrOffset(e1, Add2Ptr(hdr, used)));
  3570	
  3571			hdr->used = cpu_to_le32(used - nsize);
  3572	
  3573			a_dirty = true;
  3574	
  3575			ntfs_fix_pre_write(&ib->rhdr, bytes);
  3576			break;
  3577	
  3578		case WriteEndOfIndexBuffer:
  3579			ib = Add2Ptr(buffer_le, roff);
  3580			hdr = &ib->ihdr;
  3581			e = Add2Ptr(ib, aoff);
  3582	
  3583			if (is_baad(&ib->rhdr))
  3584				goto dirty_vol;
  3585			if (!check_lsn(&ib->rhdr, rlsn))
  3586				goto out;
  3587			if (!check_index_buffer(ib, bytes) ||
  3588			    !check_if_alloc_index(hdr, aoff) ||
  3589			    aoff + dlen > offsetof(struct INDEX_BUFFER, ihdr) +
  3590						  le32_to_cpu(hdr->total)) {
  3591				goto dirty_vol;
  3592			}
  3593	
  3594			hdr->used = cpu_to_le32(dlen + PtrOffset(hdr, e));
  3595			memmove(e, data, dlen);
  3596	
  3597			a_dirty = true;
  3598			ntfs_fix_pre_write(&ib->rhdr, bytes);
  3599			break;
  3600	
  3601		case SetIndexEntryVcnAllocation:
  3602			ib = Add2Ptr(buffer_le, roff);
  3603			hdr = &ib->ihdr;
  3604			e = Add2Ptr(ib, aoff);
  3605	
  3606			if (is_baad(&ib->rhdr))
  3607				goto dirty_vol;
  3608	
  3609			if (!check_lsn(&ib->rhdr, rlsn))
  3610				goto out;
  3611			if (!check_index_buffer(ib, bytes) ||
  3612			    !check_if_alloc_index(hdr, aoff)) {
  3613				goto dirty_vol;
  3614			}
  3615	
  3616			de_set_vbn_le(e, *(__le64 *)data);
  3617	
  3618			a_dirty = true;
  3619			ntfs_fix_pre_write(&ib->rhdr, bytes);
  3620			break;
  3621	
  3622		case UpdateFileNameAllocation:
  3623			ib = Add2Ptr(buffer_le, roff);
  3624			hdr = &ib->ihdr;
  3625			e = Add2Ptr(ib, aoff);
  3626	
  3627			if (is_baad(&ib->rhdr))
  3628				goto dirty_vol;
  3629	
  3630			if (!check_lsn(&ib->rhdr, rlsn))
  3631				goto out;
  3632			if (!check_index_buffer(ib, bytes) ||
  3633			    !check_if_alloc_index(hdr, aoff)) {
  3634				goto dirty_vol;
  3635			}
  3636	
  3637			fname = (struct ATTR_FILE_NAME *)(e + 1);
  3638			memmove(&fname->dup, data, sizeof(fname->dup));
  3639	
  3640			a_dirty = true;
  3641			ntfs_fix_pre_write(&ib->rhdr, bytes);
  3642			break;
  3643	
  3644		case SetBitsInNonresidentBitMap:
  3645			off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
  3646			bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
  3647	
  3648			if (cbo + (off + 7) / 8 > lco ||
  3649			    cbo + ((off + bits + 7) / 8) > lco) {
  3650				goto dirty_vol;
  3651			}
  3652	
  3653			ntfs_bitmap_set_le(Add2Ptr(buffer_le, roff), off, bits);
  3654			a_dirty = true;
  3655			break;
  3656	
  3657		case ClearBitsInNonresidentBitMap:
  3658			off = le32_to_cpu(((struct BITMAP_RANGE *)data)->bitmap_off);
  3659			bits = le32_to_cpu(((struct BITMAP_RANGE *)data)->bits);
  3660	
  3661			if (cbo + (off + 7) / 8 > lco ||
  3662			    cbo + ((off + bits + 7) / 8) > lco) {
  3663				goto dirty_vol;
  3664			}
  3665	
  3666			ntfs_bitmap_clear_le(Add2Ptr(buffer_le, roff), off, bits);
  3667			a_dirty = true;
  3668			break;
  3669	
  3670		case UpdateRecordDataAllocation:
  3671			ib = Add2Ptr(buffer_le, roff);
  3672			hdr = &ib->ihdr;
  3673			e = Add2Ptr(ib, aoff);
  3674	
  3675			if (is_baad(&ib->rhdr))
  3676				goto dirty_vol;
  3677	
  3678			if (!check_lsn(&ib->rhdr, rlsn))
  3679				goto out;
  3680			if (!check_index_buffer(ib, bytes) ||
  3681			    !check_if_alloc_index(hdr, aoff)) {
  3682				goto dirty_vol;
  3683			}
  3684	
  3685			if (ntfs3_bad_de_range(e, dlen))
  3686				goto dirty_vol;
  3687	
  3688			memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
  3689	
  3690			a_dirty = true;
  3691			ntfs_fix_pre_write(&ib->rhdr, bytes);
  3692			break;
  3693	
  3694		default:
  3695			WARN_ON(1);
  3696		}
  3697	
  3698		if (rlsn) {
  3699			__le64 t64 = cpu_to_le64(*rlsn);
  3700	
  3701			if (rec)
  3702				rec->rhdr.lsn = t64;
  3703			if (ib)
  3704				ib->rhdr.lsn = t64;
  3705		}
  3706	
  3707		if (mi && mi->dirty) {
  3708			err = mi_write(mi, 0);
  3709			if (err)
  3710				goto out;
  3711		}
  3712	
  3713		if (a_dirty) {
  3714			attr = oa->attr;
  3715			err = ntfs_sb_write_run(sbi, oa->run1, vbo, buffer_le, bytes,
  3716						0);
  3717			if (err)
  3718				goto out;
  3719		}
  3720	
  3721	out:
  3722	
  3723		if (inode)
  3724			iput(inode);
  3725		else if (mi != mi2_child)
  3726			mi_put(mi);
  3727	
  3728		kfree(buffer_le);
  3729	
  3730		return err;
  3731	
  3732	dirty_vol:
  3733		log->set_dirty = true;
  3734		goto out;
  3735	}
  3736	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

